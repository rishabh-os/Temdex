import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:temdex/Data/TypeData.dart';
import 'dart:math';

class TypeMatchup extends StatelessWidget {
  const TypeMatchup({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> defenderRow = types
        .map(
          (e) => Image.asset(
            "assets/Icons/Types/$e.png",
            scale: 5,
            isAntiAlias: true,
          ),
        )
        .toList();

    var legend = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 2,
            top: 18,
            child: Transform.rotate(
              angle: pi / 360 * 90,
              child: const Text("ATK",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            left: 15,
            top: 8,
            child: Transform.rotate(
              angle: pi / 360 * 90,
              child: const Text("DEF",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          CustomPaint(
            painter: MyPainter(),
          ),
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("Type Matchups"),
        ),
        body: StickyHeadersTable(
            cellDimensions: const CellDimensions.uniform(width: 40, height: 40),
            columnsLength: types.length,
            legendCell: legend,
            rowsLength: types.length,
            columnsTitleBuilder: (i) => defenderRow[i],
            rowsTitleBuilder: (i) => defenderRow[i],
            contentCellBuilder: (i, j) {
              var val = typeMatchUps[j][i];
              Color bg;
              String displayText;
              // ? Switch case throws an error, and in general, comparing floats isn't recommended in _any_ programming language. But it's not mission critical here so I do it anyway

              if (val == 0.5) {
                bg = Colors.amber;
                displayText = val.toString();
              } else if (val == 2.0) {
                bg = Colors.teal;
                displayText = val.toString();
              } else {
                bg = Theme.of(context).scaffoldBackgroundColor;
                displayText = "";
              }
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: bg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      displayText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ));
            }));
  }
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset(0, 0);
    // ? Not sure why this is 2 pixels less but assuming it's due to widget's internal padding
    const p2 = Offset(38, 38);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
