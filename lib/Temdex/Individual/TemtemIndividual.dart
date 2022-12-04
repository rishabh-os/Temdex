import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temtem_wiki/Temdex/Individual/Info.dart';
import 'package:temtem_wiki/Temdex/Individual/Location.dart';
import 'package:temtem_wiki/Temdex/Individual/Stats.dart';
import 'package:temtem_wiki/Temdex/Individual/Techniques.dart';
import 'package:temtem_wiki/Temdex/Individual/Traits.dart';
import 'package:temtem_wiki/Data/data_provider.dart';
import 'package:temtem_wiki/Temdex/Individual/TypeMatchup.dart';

class TemtemIndividual extends ConsumerStatefulWidget {
  const TemtemIndividual(
      {Key? key, required this.temNumber, required this.color})
      : super(key: key);
  final int temNumber;
  final Color color;

  @override
  ConsumerState<TemtemIndividual> createState() => _TemtemIndividualState();
}

class _TemtemIndividualState extends ConsumerState<TemtemIndividual> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);
  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  List<BottomNavigationBarItem> navItems = {
    'Stats': Icons.bar_chart,
    'Abilities': Icons.lightbulb_rounded,
    'Misc': Icons.auto_graph,
  }
      .entries
      .map(
        (
          e,
        ) =>
            (BottomNavigationBarItem(
          icon: Icon(e.value),
          label: e.key,
        )),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    var temtem = ref
        .watch(temtemProvider)
        .firstWhere((element) => element.number == widget.temNumber);

    Image temtemGIF = Image.asset(
      "assets/Temtem/Renders/Static/M${widget.temNumber.toString().padLeft(3, "0")}_Normal.png",
      scale: 4,
      fit: BoxFit.scaleDown,
      isAntiAlias: true,
      // ? Handle error in case of multiple forms
      errorBuilder: (context, error, stackTrace) => Image.asset(
        "assets/Temtem/Renders/Static/M${widget.temNumber.toString().padLeft(3, "0")}_Digital_Normal.png",
        scale: 4,
        isAntiAlias: true,
      ),
    );

    var imgAndStats = ListView(children: [
      Container(
        height: 250,
        color: widget.color,
        child: temtemGIF,
      ),
      InfoSection(
        sectionTitle: "Stats",
        sectionInfo: TemtemStats(stats: temtem.stats),
      ),
      InfoSection(
        sectionTitle: "Info",
        sectionInfo: TemtemInfo(
          gameDescription: temtem.gameDescription,
          details: temtem.details,
          genderRatio: temtem.genderRatio,
          catchRate: temtem.catchRate,
          hatchMins: temtem.hatchMins,
          tvYields: temtem.tvYields,
        ),
      ),
      InfoSection(
          sectionTitle: "Type Matchups",
          sectionInfo: TypeMatchup(temtemType: temtem.types!))
    ]);

    var abilities = ListView(children: [
      InfoSection(
          sectionTitle: "Traits",
          sectionInfo: TemtemTraits(traits: temtem.traits)),
      InfoSection(
          sectionTitle: "Technique List",
          sectionInfo: TemtemTechniques(techniques: temtem.techniques))
    ]);

    var locationAndEvolution = ListView(
      children: [
        InfoSection(
            sectionTitle: "Location", sectionInfo: Location(temtem: temtem))
      ],
    );
    List<Widget> widgetOptions = <Widget>[
      imgAndStats,
      abilities,
      locationAndEvolution
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: navItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        fixedColor: Theme.of(context).textTheme.titleLarge!.color,
        unselectedItemColor:
            Theme.of(context).textTheme.titleLarge!.color!.withOpacity(0.5),
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text(temtem.name),
        backgroundColor: widget.color,
        elevation: 0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: widgetOptions,
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.sectionTitle,
    required this.sectionInfo,
  }) : super(key: key);

  final String sectionTitle;
  final Widget sectionInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.black38,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Center(
                child: Text(
              sectionTitle,
              style: Theme.of(context).textTheme.headline5,
            )),
            const Divider(
              thickness: 2,
              color: Colors.black38,
            ),
            sectionInfo
          ],
        ),
      ),
    );
  }
}
