import 'package:flutter/material.dart';
import 'dart:math' as math;

class CharacterModel extends StatelessWidget {
  final Color hatColor = Colors.red;
  final Color shirtColor = Colors.cyan;
  final Color pantsColor = Colors.red[200];
  final Color shoesColor = Colors.brown;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //CHARACTER MODEL
      Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 100,
                height: 100,
                child:
                    Image.asset('images/character_model/face-detection.png'))),
      ),
      //HEADWEAR
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              width: 70,
              height: 70,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(hatColor, BlendMode.modulate),
                  child: Image.asset('images/templates/headwear/hat.png'))),
        ),
      ),
      //LEFT SHOE
      Padding(
        padding: const EdgeInsets.only(left: 145.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: 70,
              height: 70,
              child: Transform(
                transform: Matrix4.rotationY(math.pi),
                child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(shoesColor, BlendMode.modulate),
                    child:
                        Image.asset('images/templates/footwear/sneaker.png')),
              )),
        ),
      ),
      //RIGHT SHOE
      Padding(
        padding: const EdgeInsets.only(right: 75.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
              width: 70,
              height: 70,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(shoesColor, BlendMode.modulate),
                  child: Image.asset('images/templates/footwear/sneaker.png'))),
        ),
      ),
      //BOTTOM
      Padding(
        padding: const EdgeInsets.only(bottom: 42.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: 180,
              height: 180,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(pantsColor, BlendMode.modulate),
                  child: Image.asset(
                      'images/templates/bottoms/chinos-pants.png'))),
        ),
      ),
      //TOP
      Padding(
        padding: const EdgeInsets.only(top: 110.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              width: 180,
              height: 180,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(shirtColor, BlendMode.modulate),
                  child: Image.asset('images/templates/tops/sweater.png'))),
        ),
      ),
    ]);
  }
}
