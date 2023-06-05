import 'package:flutter/material.dart';
import 'package:temdex/Data/TemtemData.dart';

class TemtemInfo extends StatelessWidget {
  const TemtemInfo(
      {Key? key,
      required this.gameDescription,
      required this.details,
      required this.genderRatio,
      required this.catchRate,
      required this.hatchMins,
      required this.tvYields})
      : super(key: key);
  final String gameDescription;
  final Details? details;
  final GenderRatio genderRatio;
  final int catchRate;
  final num hatchMins;
  final TvYields? tvYields;

  @override
  Widget build(BuildContext context) {
    var givenInches = details?.height?.inches;
    var givenCm = details?.height?.cm;
    int feet = 0;
    int inches = 0;
    double meters = 0;
    if (givenInches != null) {
      feet = (givenInches ~/ 12);
      inches = givenInches - feet * 12;
    }
    if (givenCm != null) {
      meters = givenCm / 100;
    }

    var tvJson = tvYields?.toJson();
    tvJson!.removeWhere((key, value) => value == 0);
    String tvString = tvJson.entries
        .map((e) => "${e.key.toUpperCase()}: ${e.value}")
        .toList()
        .join(" | ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: FaintBorderContainer(
              child: Text(gameDescription),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: [
                [
                  Icon(Icons.expand_rounded,
                      color: Theme.of(context).colorScheme.tertiary),
                  Text("$meters m ($feet' $inches\")"),
                  Text("Height",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ],
                [
                  Icon(
                    Icons.scale_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(
                      "${details?.weight?.kg} kg (${details?.weight?.lbs} lbs)"),
                  Text("Weight",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ],
                [
                  Icon(Icons.safety_divider_rounded,
                      color: Theme.of(context).colorScheme.tertiary),
                  Text("${genderRatio.male}:${genderRatio.female}"),
                  Text("Gender Ratio",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ],
                [
                  Icon(
                    Icons.catching_pokemon_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text("$catchRate"),
                  Text("Catch Rate",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ],
                [
                  Icon(
                    Icons.timer,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text("$hatchMins min"),
                  Text("Hatch Timer",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ],
                [
                  Icon(
                    Icons.upcoming_rounded,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  Text(tvString),
                  Text("TV Yield",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14))
                ]
              ]
                  .map((e) => Padding(
                        // padding: EdgeInsets.zero,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Column(
                          children: [
                            e[2],
                            const SizedBox(
                              height: 8,
                            ),
                            FaintBorderContainer(
                                child: Row(
                              children: [
                                e[0],
                                Expanded(child: Center(child: e[1]))
                              ],
                            )),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FaintBorderContainer extends StatelessWidget {
  const FaintBorderContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
