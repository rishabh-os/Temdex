import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:temdex/Data/data_provider.dart';
import 'package:temdex/Temdex/Individual/TemtemIndividual.dart';

class TemtemCard extends ConsumerStatefulWidget {
  const TemtemCard({
    Key? key,
    required this.temNumber,
    required this.temName,
    required this.temTypes,
  }) : super(key: key);

  final int temNumber;
  final String? temName;
  final List<String>? temTypes;

  @override
  ConsumerState<TemtemCard> createState() => _TemtemCardState();
}

class _TemtemCardState extends ConsumerState<TemtemCard> {
  late String displayNumber;
  late String profileAssetPath;
  late Color col;
  @override
  void initState() {
    super.initState();
  }

  Future<PaletteGenerator> genPal() async {
    return await PaletteGenerator.fromImageProvider(
        AssetImage(profileAssetPath));
  }

  @override
  Widget build(BuildContext context) {
    displayNumber = widget.temNumber.toString().padLeft(3, "0");

    switch (ref.watch(profileImageProvider)) {
      case "Normal":
        profileAssetPath =
            "assets/Temtem/Portraits/Regular/small/M${displayNumber}_Sprite.png";
        break;
      case "Luma":
        profileAssetPath =
            "assets/Temtem/Portraits/Luma/small/M${displayNumber}_LumaSprite.png";
        break;

      case "Stickers":
        profileAssetPath = "assets/Temtem/Stickers/small/M$displayNumber.png";
        break;
      default:
        profileAssetPath =
            "assets/Temtem/Portraits/Regular/small/M${displayNumber}_Sprite.png";
    }
    col = Colors.black12;
    Widget cardNumber = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            left: -60,
            top: -43,
            child: Opacity(
              opacity: 0.14,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).shadowColor,
                radius: 55,
              ),
            ),
          ),
          Text(
            "#$displayNumber",
            style: const TextStyle(
                fontSize: 18,
                fontFamily: "VictorMono",
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    var nameAndTypes = Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.temName!,
          style: const TextStyle(fontSize: 24),
        ),
        Row(
          children: widget.temTypes!
              .map((e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.black38,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e,
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Image.asset(
                                  "assets/Icons/Types/$e.png",
                                  scale: 6,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    ));
    var profileImage = Container(
        decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(
            color: Colors.black26,
            width: 0.5,
            style: BorderStyle.solid,
          )),
        ),

        // color: Colors.tealAccent,
        child: Image.asset(
          profileAssetPath,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: child,
            );
          },
          gaplessPlayback: true,
          height: 100,
          width: 100,
        ));
    var cardSections = [cardNumber, nameAndTypes, profileImage];

    return FutureBuilder<PaletteGenerator>(
        future: genPal(), // async work
        builder:
            (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
          // * This still has a lot of edge cases so I'm not really sure how to implement something that would work for everything
          // ? primaryColor is the dominant color in the image
          Color? primaryColor = snapshot.data?.paletteColors[0].color;
          Color finalColor;
          finalColor = Theme.of(context).cardColor;
          var darkMode = Theme.of(context).brightness == Brightness.dark;
          double lightness = darkMode ? 0.4 : 0.6;
          double saturation = darkMode ? 0.6 : 0.4;
          // ? This check is always true but Flutter keeps throwing errors if it's not included
          Color color = primaryColor ?? Colors.white;
          // ? This is a fix for Temtems with a black / very dark main color
          if (HSLColor.fromColor(color).saturation < 0.1) {
            finalColor = HSLColor.fromColor(color)
                // .withLightness(lightness)
                .withAlpha(0.7)
                .toColor();
          } else {
            finalColor = HSLColor.fromColor(color)
                .withLightness(lightness)
                .withSaturation(saturation)
                .toColor();
          }

          return Card(
            color: finalColor,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            elevation: 0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TemtemIndividual(
                        temNumber: widget.temNumber, color: finalColor),
                  ),
                );
              },
              child: SizedBox(
                height: 100,
                child: Row(
                  children: cardSections,
                ),
              ),
            ),
          );
        });
  }
}
