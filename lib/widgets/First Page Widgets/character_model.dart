import 'package:flutter/material.dart';

class CharacterModel extends StatelessWidget {
  final Color hatColor = Colors.red;
  final Color shirtColor = Colors.black;
  final Color pantsColor = Colors.red[200];
  final Color shoesColor = Colors.brown;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('images/character_model.png'),
      Container(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(hatColor, BlendMode.modulate),
              child: Image.asset('images/templates/head/blank_fedora.png'))),
      Container(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(shirtColor, BlendMode.modulate),
              child: Image.asset('images/templates/top/blank_shirt.png'))),
      Container(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(pantsColor, BlendMode.modulate),
              child: Image.asset('images/templates/legs/blank_pants.png'))),
      Container(
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(shoesColor, BlendMode.modulate),
              child: Image.asset('images/templates/feet/blank_shoes.png'))),
    ]);
  }
}
