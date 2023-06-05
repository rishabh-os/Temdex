import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temdex/Data/TemtemData.dart';
import 'package:temdex/Data/data_provider.dart';
import 'package:temdex/Temdex/TemtemCard.dart';

class SearchAllFAB extends StatelessWidget {
  const SearchAllFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionDuration: const Duration(milliseconds: 300),
        closedBuilder: (_, openContainer) {
          return FloatingActionButton(
            tooltip: "Search",
            elevation: 5.0,
            onPressed: openContainer,
            child: const Icon(Icons.search),
          );
        },
        openColor: Theme.of(context).colorScheme.secondary,
        closedElevation: 5.0,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
        closedColor: Theme.of(context).colorScheme.secondary,
        openBuilder: (_, closeContainer) {
          return const SearchAll();
        });
  }
}

class SearchAll extends ConsumerStatefulWidget {
  const SearchAll({Key? key}) : super(key: key);

  @override
  SearchAllState createState() => SearchAllState();
}

class SearchAllState extends ConsumerState<SearchAll> {
  late List<Temtem> temtems;
  final FocusNode _node = FocusNode();
  @override
  void initState() {
    super.initState();
    temtems = ref.read(temtemProvider);
    // ? Autofocuses the search bar after 150ms, combined with the
    // ? animation delay it's basically instant
    Future.delayed(const Duration(milliseconds: 150)).then((_) {
      FocusScope.of(context).requestFocus(_node);
    });
  }

  List<Temtem>? results;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: Scaffold(
          // ! Todo: The FAB glitches when returning to the main view
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                focusNode: _node,
                controller: controller,
                onChanged: search,
                hintText: "Search Temtem by name or number",
                trailing: [
                  IconButton(
                    splashRadius: 20,
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      controller.clear();
                      setState(() {
                        results = null;
                      });
                    },
                  )
                ],
              ),
            ),
            // title: TextField(
            //   autofocus: true,
            //   controller: controller,
            //   decoration: InputDecoration(
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //       border: const OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(50))),
            //       isDense: true,
            //       hintText: "Search Temtem by name or number",
            //       suffixIcon: IconButton(
            //         splashRadius: 20,
            //         icon: const Icon(
            //           Icons.close,
            //           color: Colors.red,
            //         ),
            //         onPressed: () {
            //           controller.clear();
            //           setState(() {
            //             results = null;
            //           });
            //         },
            //       )),
            //   textCapitalization: TextCapitalization.words,
            //   onChanged: search,
            // ),
          ),
          body: results == null
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    children: results!
                        .map((e) => TemtemCard(
                            temNumber: e.number,
                            temName: e.name,
                            temTypes: e.types))
                        .toList(),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_downward_rounded),
          ),
        ),
      ),
    );
  }

  void search(searchString) {
    // ? Search by name
    if (searchString.isNotEmpty && double.tryParse(searchString) == null) {
      List<Temtem> temp = [];
      for (var temtem in temtems) {
        if (temtem.name.toLowerCase().contains(searchString.toLowerCase())) {
          temp.add(temtem);
        }
      }
      setState(() {
        results = temp;
      });
    }
    // ? Search by number
    else if (searchString.isNotEmpty && double.tryParse(searchString) != null) {
      List<Temtem> temp = [];
      for (var temtem in temtems) {
        if (temtem.number == double.parse(searchString)) {
          temp.add(temtem);
        }
      }
      setState(() {
        results = temp;
      });
    } else {
      results = null;
    }
  }
}
