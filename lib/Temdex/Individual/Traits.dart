import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temdex/Data/TraitData.dart';
import 'package:temdex/Data/data_provider.dart';

class TemtemTraits extends StatelessWidget {
  const TemtemTraits({Key? key, required this.traits}) : super(key: key);
  final List<String> traits;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...traits
          .map((e) => Traits(
                traitName: e,
              ))
          .toList(),
      const SizedBox(
        height: 4,
      )
    ]);
  }
}

class Traits extends StatelessWidget {
  const Traits({Key? key, required this.traitName}) : super(key: key);
  final String traitName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                child: Text(
                  traitName,
                ),
                onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Wrap(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
                          child: Consumer(
                            builder: (context, ref, child) {
                              var x = ref.read(traitProvider);

                              var effect = x.firstWhere(
                                (element) => element.name == traitName,
                                orElse: () {
                                  if (traitName == "Attack<T>") {
                                    return x.firstWhere((element) =>
                                        element.name == "Attack T");
                                  } else {
                                    return Trait(
                                        name: "",
                                        wikiUrl: "",
                                        description: "",
                                        effect: "Unable to load trait info");
                                  }
                                },
                              ).effect;
                              return Column(children: [
                                Text(
                                  traitName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiaryContainer),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(effect)
                              ]);
                            },
                          ),
                        ),
                      ]);
                    })),
          ),
        ),
      ],
    );
  }
}
