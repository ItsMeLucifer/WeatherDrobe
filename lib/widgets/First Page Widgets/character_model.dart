import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/viewmodels/First%20Page/clothing_chooser.dart';
import 'package:weatherdrobe/viewmodels/tools.dart';

class CharacterModel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final cc = watch(clothingChooser);
    final favm = watch(firebaseAuth);
    final hfvm = watch(hourlyData);
    final tools = watch(toolsVM);
    if (vwvm.userCollections != null && vwvm.userCollections.exists) {
      if ((vwvm.headwear.isNotEmpty &&
              vwvm.tops.isNotEmpty &&
              vwvm.bottoms.isNotEmpty &&
              vwvm.footwear.isNotEmpty) ||
          (vwvm.headwear.isNotEmpty &&
              vwvm.costumes.isNotEmpty &&
              vwvm.footwear.isNotEmpty)) {
        hfvm.getTemperaturesAndWeatherIds();
        cc.chooseClothing(vwvm.headwear, vwvm.tops, vwvm.bottoms, vwvm.footwear,
            vwvm.costumes, 10, 300, false);
      }
      return model(tools, cc);
    } else {
      vwvm.getGarments(favm.auth);
      return Padding(
        padding: const EdgeInsets.only(top: 215.0, right: 112.5, bottom: 215),
        child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(tools.textColor),
            )),
      );
    }
  }

  Widget model(Tools tools, ClothingChooser cc) {
    return Card(
      color: tools.secondaryColor,
      child: Container(
        width: 275,
        height: 550,
        child: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 135.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 200,
                      height: 400,
                      child: Image.asset('images/icons/mannequin.png'))),
            ),
            //COUNTER
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cc.proposals.length > 0
                        ? '${cc.currentModelIndex + 1}/${cc.proposals.length}'
                        : 'Not enough clothes',
                    style: TextStyle(
                        fontFamily: tools.fontFamily,
                        color: tools.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            //HEADWEAR
            cc.proposals.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 95.0, right: 3),
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
                    padding: const EdgeInsets.only(bottom: 27, left: 190),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 55,
                          height: 55,
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
                    padding: const EdgeInsets.only(bottom: 27, left: 220),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 55,
                          height: 55,
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
            cc.proposals.isNotEmpty &&
                    !cc.proposals[cc.currentModelIndex].isCostume
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 65.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: 195,
                          height: 195,
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
            cc.proposals.isNotEmpty &&
                    !cc.proposals[cc.currentModelIndex].isCostume
                ? Padding(
                    padding: const EdgeInsets.only(left: 0, top: 170.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 205,
                          height: 205,
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
            //COSTUME
            cc.proposals.isNotEmpty &&
                    cc.proposals[cc.currentModelIndex].isCostume
                ? Padding(
                    padding: const EdgeInsets.only(left: 0, top: 180.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 250,
                          height: 250,
                          child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  new Color(int.parse(cc
                                      .proposals[cc.currentModelIndex]
                                      .top['color'])),
                                  BlendMode.modulate),
                              child: Image.asset(
                                  'images/templates/costumes/${cc.proposals[cc.currentModelIndex].top["dir"]}.png'))),
                    ),
                  )
                : Container(),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (cc.currentModelIndex > 0) {
                      cc.currentModelIndex--;
                    }
                  },
                  child: Container(
                    height: 300,
                    width: 70,
                    child: Icon(Icons.arrow_back_ios,
                        color: cc.currentModelIndex > 0
                            ? tools.textColor
                            : tools.disabledColor),
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
                    }
                  },
                  child: Container(
                      height: 300,
                      width: 70,
                      child: Icon(Icons.arrow_forward_ios,
                          color:
                              cc.currentModelIndex < cc.proposals.length - 1 ||
                                      cc.amountOfFreeClothing > 0
                                  ? tools.textColor
                                  : tools.disabledColor)),
                )),
            cc.notEnoughData
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Icon(Icons.error_outline))
                : Container()
          ]),
        ),
      ),
    );
  }
}
