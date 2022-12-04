import 'package:flutter/material.dart';
import 'package:temtem_wiki/Data/TemtemData.dart';

class Location extends StatelessWidget {
  const Location({
    Key? key,
    required this.temtem,
  }) : super(key: key);

  final Temtem temtem;

  @override
  Widget build(BuildContext context) {
    var list = temtem.locations!
        .map((e) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    height: 55,
                    child: Center(
                      child: Text(
                        "${e.location!} - ${e.island!}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: Center(
                    child: Text(
                      e.level!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: Center(
                    child: Text(
                      e.frequency!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ))
        .toList();

    list.insert(
        0,
        TableRow(
            children: ["Location", "Level Range", "Frequency"]
                .map((e) => TableCell(
                        child: SizedBox(
                      height: 25,
                      child: Center(
                        child: Text(
                          e,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )))
                .toList()));
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: list.length == 1
          ? const Text("This Temtem is not found in the wild")
          : Table(
              children: list,
              columnWidths: const {
                0: FlexColumnWidth(10),
                1: FlexColumnWidth(6),
                2: FlexColumnWidth(6),
              },
            ),
    );
  }
}
