import 'package:flutter/material.dart';
import 'package:temtem_wiki/Data/TemtemData.dart';

class TemtemStats extends StatefulWidget {
  const TemtemStats({Key? key, required this.stats}) : super(key: key);
  final Stats stats;

  @override
  State<TemtemStats> createState() => _TemtemStatsState();
}

class _TemtemStatsState extends State<TemtemStats> {
  bool expanded = false;

  void _updateSize() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSize());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        children: [
          ...widget.stats
              .toJson()
              .entries
              .map((e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Center(
                              child: Text(
                            e.key.toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeOutCirc,
                                child: SizedBox(
                                  height: 6,
                                  // ? Normalize the width of the columns, the -96 is because LayoutBuilder doesn't work as a child of Column so it's a manual adjustment
                                  width: expanded
                                      ? ((constraints.maxWidth - 96) - 0) /
                                              (110 - 0) *
                                              (e.value / 1 - 110) +
                                          (constraints.maxWidth - 96)
                                      : 0,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -25,
                              child: Text(
                                e.value.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
              .toList()
              .sublist(0, 7),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total ${widget.stats.total}".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          )
        ],
      );
    });
  }
}
