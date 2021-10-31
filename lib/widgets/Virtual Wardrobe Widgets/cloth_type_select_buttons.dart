import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothTypeSelectButtons extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final tools = watch(toolsVM);
    const double talesWidth = 65;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              vwvm.actualClothType = 0;
            },
            child: Card(
              child: Container(
                  height: 60,
                  width: talesWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 10),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.purple[300], BlendMode.modulate),
                      child: Image.asset(
                          'images/templates/headwear/winter-hat.png'),
                    ),
                  )),
              color: vwvm.actualClothType == 0
                  ? tools.secondaryColor
                  : tools.quinaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.actualClothType = 4;
            },
            child: Card(
              child: Container(
                  height: 60,
                  width: talesWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, top: 10),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.pink[300], BlendMode.modulate),
                      child: Image.asset(
                          'images/templates/costumes/cocktail-dress.png'),
                    ),
                  )),
              color: vwvm.actualClothType == 4
                  ? tools.secondaryColor
                  : tools.quinaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.actualClothType = 1;
            },
            child: Card(
                child: Container(
                    height: 60,
                    width: talesWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.green[300], BlendMode.modulate),
                        child: Image.asset(
                            'images/templates/tops/denim-shirt.png'),
                      ),
                    )),
                color: vwvm.actualClothType == 1
                    ? tools.secondaryColor
                    : tools.quinaryColor),
          ),
          GestureDetector(
            onTap: () {
              vwvm.actualClothType = 2;
            },
            child: Card(
              child: Container(
                  height: 60,
                  width: talesWidth,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, top: 5, bottom: 5),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Colors.blue[300], BlendMode.modulate),
                      child: Image.asset('images/templates/bottoms/jeans.png'),
                    ),
                  )),
              color: vwvm.actualClothType == 2
                  ? tools.secondaryColor
                  : tools.quinaryColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.actualClothType = 3;
            },
            child: Card(
              child: Container(
                  height: 60,
                  width: talesWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                    child: ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(Colors.grey, BlendMode.modulate),
                      child:
                          Image.asset('images/templates/footwear/sneakers.png'),
                    ),
                  )),
              color: vwvm.actualClothType == 3
                  ? tools.secondaryColor
                  : tools.quinaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
