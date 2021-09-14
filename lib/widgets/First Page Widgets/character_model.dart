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
    List<double> weatherIds = List<double>();
    if (vwvm.headwear.isNotEmpty &&
        vwvm.tops.isNotEmpty &&
        vwvm.bottoms.isNotEmpty &&
        vwvm.footwear.isNotEmpty) {
      int tempCounter = 0;
      hfvm.hours.forEach((hour) => {
            tempCounter++,
            if (tempCounter < 10)
              {
                temperatures.add(hour.temperature),
                weatherIds.add(hour.weatherId.toDouble())
              }
          });
      cc.chooseClothing(
          vwvm.headwear,
          vwvm.tops,
          vwvm.bottoms,
          vwvm.footwear,
          vwvm.costumes,
          10,
          tools.calculateTheMedian(weatherIds).toInt(),
          false);
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
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('${cc.currentModelIndex + 1}/${cc.proposals.length}'),
              )),
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
                                new Color(int.parse(cc
                                    .proposals[cc.currentModelIndex]
                                    .headwear['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/headwear/${cc.proposals[cc.currentModelIndex].headwear['dir']}.png'))),
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
                                  new Color(int.parse(cc
                                      .proposals[cc.currentModelIndex]
                                      .footwear['color'])),
                                  BlendMode.modulate),
                              child: Image.asset(
                                  'images/templates/footwear/${cc.proposals[cc.currentModelIndex].footwear['dir']}.png')),
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
                                  new Color(int.parse(cc
                                      .proposals[cc.currentModelIndex]
                                      .footwear['color'])),
                                  BlendMode.modulate),
                              child: Image.asset(
                                  'images/templates/footwear/${cc.proposals[cc.currentModelIndex].footwear['dir']}.png')),
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
                                new Color(int.parse(cc
                                    .proposals[cc.currentModelIndex]
                                    .bottom['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/bottoms/${cc.proposals[cc.currentModelIndex].bottom["dir"]}.png'))),
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
                                new Color(int.parse(cc
                                    .proposals[cc.currentModelIndex]
                                    .top['color'])),
                                BlendMode.modulate),
                            child: Image.asset(
                                'images/templates/tops/${cc.proposals[cc.currentModelIndex].top["dir"]}.png'))),
                  ),
                )
              : Container(),
          Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  if (cc.currentModelIndex > 0) {
                    cc.currentModelIndex--;
                    print('INDEX: ' + cc.currentModelIndex.toString());
                  }
                },
                child: Container(
                  height: 300,
                  width: 70,
                  child: Icon(Icons.arrow_back_ios,
                      color: cc.currentModelIndex > 0
                          ? Colors.black
                          : Colors.grey),
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  if (cc.currentModelIndex < cc.proposals.length - 1) {
                    cc.currentModelIndex++;
                  } else if (cc.amountOfFreeClothing > 0) {
                    //CREATE NEW MODELS, BUT IN THE FUNCTION USE PREF_LISTS NOT LISTS FROM THE FIREBASE
                    cc.chooseClothing(
                        null, null, null, null, null, null, null, true);
                    cc.currentModelIndex++;
                    print('INDEX: ' + cc.currentModelIndex.toString());
                  }
                },
                child: Container(
                    height: 300,
                    width: 70,
                    child: Icon(Icons.arrow_forward_ios,
                        color: cc.currentModelIndex < cc.proposals.length - 1 ||
                                cc.amountOfFreeClothing > 0
                            ? Colors.black
                            : Colors.grey)),
              )),
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
