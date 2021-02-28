import 'package:flutter/material.dart';
import 'dart:math' as math;

class CharacterModel extends StatelessWidget {
  final Color hatColor = Colors.red;
  final Color shirtColor = Colors.black;
  final Color pantsColor = Colors.red[200];
  final Color shoesColor = Colors.brown;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(190, 190, 190, 1), BlendMode.modulate),
                  child: Image.asset('images/character_model2.png'))),
        ),
        Transform.rotate(
          angle: -math.pi / 4,
          child: Center(
            child: Text(
              'Character Model',
              style: TextStyle(
                  fontFamily: 'Nexa',
                  fontSize: 37,
                  color: Color.fromRGBO(120, 120, 120, 1)),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
    // return Stack(children: [
    //   Image.asset('images/character_model.png'),
    //   Container(
    //       child: ColorFiltered(
    //           colorFilter: ColorFilter.mode(hatColor, BlendMode.modulate),
    //           child: Image.asset('images/templates/head/blank_fedora.png'))),
    //   Container(
    //       child: ColorFiltered(
    //           colorFilter: ColorFilter.mode(shirtColor, BlendMode.modulate),
    //           child: Image.asset('images/templates/top/blank_shirt.png'))),
    //   Container(
    //       child: ColorFiltered(
    //           colorFilter: ColorFilter.mode(pantsColor, BlendMode.modulate),
    //           child: Image.asset('images/templates/legs/blank_pants.png'))),
    //   Container(
    //       child: ColorFiltered(
    //           colorFilter: ColorFilter.mode(shoesColor, BlendMode.modulate),
    //           child: Image.asset('images/templates/feet/blank_shoes.png'))),
    // ]);
  }
}
