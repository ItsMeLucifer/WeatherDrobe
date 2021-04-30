import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class CharacterModel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final cc = watch(clothingChooser);
    final hfvm = watch(hourlyData);
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    List<double> temperatures = List<double>();

    if (vwvm.headwear.isNotEmpty &&
        vwvm.tops.isNotEmpty &&
        vwvm.bottoms.isNotEmpty &&
        vwvm.footwear.isNotEmpty) {
      hfvm.hours.forEach((hour) => temperatures.add(hour.temperature));
      cc.chooseClothing(
          vwvm.headwear,
          vwvm.tops,
          vwvm.bottoms,
          vwvm.footwear,
          vwvm.costumes,
          tools.calculateTheMedian(temperatures),
          [false, false, false, false]);
    }
    if (vwvm.userCollections != null && vwvm.userCollections.exists) {
      return SafeArea(
        child: Stack(children: [
          //CHARACTER MODEL
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: 300,
                    height: 400,
                    child: Image.asset(
                        'images/character_model/male_character_model.png'))),
          ),
          //HEADWEAR
          cc.proposals.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 90,
                        height: 90,
                        child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                new Color(int.parse(
                                    cc.proposals[0].headwear['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/headwear/men-hat.png'))),
                  ),
                )
              : Container(),
          //LEFT SHOE
          cc.proposals.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 35, left: 90),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 70,
                        height: 70,
                        child: Transform(
                          transform: Matrix4.rotationY(math.pi),
                          child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  new Color(int.parse(
                                      cc.proposals[0].footwear['color'])),
                                  BlendMode.modulate),
                              child: Image.asset(
                                  'images/templates/footwear/${cc.proposals[0].footwear['dir']}.png')),
                        )),
                  ),
                )
              : Container(),
          //RIGHT SHOE
          cc.proposals.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 36, left: 140),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 70,
                        height: 70,
                        child: Transform(
                          transform: Matrix4.rotationY(math.pi),
                          child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  new Color(int.parse(
                                      cc.proposals[0].footwear['color'])),
                                  BlendMode.modulate),
                              child: Image.asset(
                                  'images/templates/footwear/${cc.proposals[0].footwear['dir']}.png')),
                        )),
                  ),
                )
              : Container(),
          //BOTTOM
          cc.proposals.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 110.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 160,
                        height: 160,
                        child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                new Color(
                                    int.parse(cc.proposals[0].bottom['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/bottoms/${cc.proposals[0].bottom["dir"]}.png'))),
                  ),
                )
              : Container(),
          //TOP
          cc.proposals.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 103.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                new Color(
                                    int.parse(cc.proposals[0].top['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/tops/${cc.proposals[0].top["dir"]}.png'))),
                  ),
                )
              : Container(),
          cc.notEnoughData
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(Icons.error_outline))
              : Container()
        ]),
      );
    } else {
      vwvm.getGarments(favm.auth);
      return Container(
          width: 50, height: 50, child: CircularProgressIndicator());
    }
  }
}
