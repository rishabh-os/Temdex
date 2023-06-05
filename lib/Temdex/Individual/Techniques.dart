import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temdex/Data/TechniqueData.dart';
import 'package:temdex/Data/TemtemData.dart';
import 'package:temdex/Data/data_provider.dart';

class TemtemTechniques extends StatelessWidget {
  const TemtemTechniques({Key? key, required this.techniques})
      : super(key: key);
  final List<Techniques> techniques;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = techniques
        .map(
          (technique) => ExpandablePanel(
              theme: const ExpandableThemeData(hasIcon: false),
              header: Table(
                border: TableBorder(
                    verticalInside: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        style: BorderStyle.solid)),
                children: [
                  TableRow(
                      children: technique
                          .toJson()
                          .entries
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      // ? To catch levels for techniques that aren't learned through levelling up
                                      e.value != null
                                          ? e.value.toString()
                                          : '-',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ))
                          .toList())
                ],
              ),
              collapsed: const SizedBox(),
              expanded: Consumer(
                builder: (context, ref, child) {
                  var x = ref.watch(techniqueProvider);
                  var tech =
                      x.firstWhere((element) => element.name == technique.name);

                  return TechniqueDetails(tech: tech);
                },
              )),
        )
        .toList();
    list.insert(
        0,
        ExpandablePanel(
          theme: const ExpandableThemeData(hasIcon: false, useInkWell: false),
          collapsed: const SizedBox(),
          expanded: const SizedBox(),
          header: Table(
            border: TableBorder(
                verticalInside: BorderSide(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    style: BorderStyle.solid)),
            children: [
              TableRow(
                  children: ["Name", "Source", "Level"]
                      .map((e) => TableCell(
                              child: SizedBox(
                            height: 25,
                            child: Center(
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )))
                      .toList())
            ],
          ),
        ));
    return Column(
      children: list,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class TechniqueDetails extends StatelessWidget {
  const TechniqueDetails({
    Key? key,
    required this.tech,
  }) : super(key: key);

  final TechniqueData tech;

  @override
  Widget build(BuildContext context) {
    String classs = tech.classs!.capitalize();
    String priority = tech.priority!.startsWith("very")
        ? "Very${tech.priority!.substring(4).capitalize()}"
        : tech.priority!.capitalize();

    Widget synergy = tech.synergy! == "None"
        // ? Acts as padding when there is no synergy
        ? const SizedBox()
        : Column(
            children: [
              const Text("Synergy:"),
              Image.asset(
                "assets/Icons/Types/${tech.synergy}.png",
                scale: 6,
                semanticLabel: tech.type,
              ),
              Text("${tech.synergy}"),
              Row(
                children: [
                  for (var i in tech.synergyEffects!)
                    Text(
                      "  ${i.effect!}",
                      maxLines: 1,
                    ),
                ],
              )
            ],
          );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //     width: 2,
          //     color: Theme.of(context).colorScheme.tertiaryContainer)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: {
                    "ATK: ${tech.damage}":
                        Theme.of(context).colorScheme.errorContainer,
                    "STA: ${tech.staminaCost}": Colors.green,
                    "HOLD: ${tech.hold}": Theme.of(context).colorScheme.outline,
                  }
                      .entries
                      .map((e) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: e.value,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Center(
                                        child: Text(
                                      e.key,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                Row(
                  children: {
                    classs: Image.asset(
                      "assets/Icons/Techniques/UI-Common_Techniques_Categories_$classs.png",
                      scale: 2.5,
                      semanticLabel: classs,
                    ),
                    tech.type: Image.asset(
                      "assets/Icons/Types/${tech.type}.png",
                      scale: 6,
                      semanticLabel: tech.type,
                    ),
                    priority: Image.asset(
                      "assets/Icons/Techniques/UI-Common_Techniques_Priority_$priority.png",
                      scale: 2.5,
                      semanticLabel: priority,
                    ),
                  }
                      .entries
                      .map((e) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Column(
                                      children: [
                                        e.value,
                                        Center(
                                            child: Text(
                                          e.key!,
                                        )),
                                      ],
                                    ),
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      child: Text("Target(s): ${tech.targets}"),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tech.description!),
                      // ? Effect text is redundant in most situations
                      // tech.effectText != null
                      //     ? Text(tech.effectText!)
                      //     : const SizedBox(),
                    ],
                  ),
                ),
                synergy,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
