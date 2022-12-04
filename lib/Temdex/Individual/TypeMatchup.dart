import 'package:flutter/material.dart';
import 'package:temtem_wiki/Data/TypeData.dart';

class TypeMatchup extends StatelessWidget {
  const TypeMatchup({
    Key? key,
    required this.temtemType,
  }) : super(key: key);

  final List<String> temtemType;

  @override
  Widget build(BuildContext context) {
    List<List<double>> effectiveTable = [];
    for (var i in temtemType) {
      var col = typeMatchUps
          .map<double>((row) => row[types.indexOf(i)])
          .toList(growable: false);
      effectiveTable.add(col);
    }
    List<double> finalValues = [];
    // ? For dual types
    if (effectiveTable.length == 2) {
      for (var i = 0; i < 12; i++) {
        var x = effectiveTable[0][i] * effectiveTable[1][i];
        finalValues.add(x);
      }
    } else {
      finalValues = effectiveTable[0];
    }
    final Map<String, double> z = Map.fromIterables(types, finalValues);

    List<String> resistant = [];
    List<String> weak = [];
    List<String> superWeak = [];

    z.forEach((key, value) {
      if (value == 0.5) {
        resistant.add(key);
      } else if (value == 2.0) {
        weak.add(key);
      } else if (value == 4.0) {
        superWeak.add(key);
      }
    });

    var displayNametoTypesMap = Map<String, List<String>>.fromIterables(
        ["Very Weak (x4)", "Weak (x2)", "Resistant (x0.5)"],
        [superWeak, weak, resistant]);
    if (displayNametoTypesMap["Very Weak (x4)"]!.isEmpty) {
      displayNametoTypesMap.remove("Very Weak (x4)");
    }
    var displayList = displayNametoTypesMap.entries
        .map((e) => TableRow(children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    e.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: [
                  for (var i in e.value)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/Icons/Types/$i.png",
                        scale: 6,
                        semanticLabel: i,
                      ),
                    ),
                ],
              )
            ]))
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Table(
        children: displayList,
      ),
    );
  }
}
