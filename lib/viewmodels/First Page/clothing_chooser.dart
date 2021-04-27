import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherdrobe/models/clothing.dart';

enum ClothType { headwear, tops, bottoms, footwear, costumes }
enum bestWeathersTemperatureForCloth {
  freezing,
  cold,
  chilly,
  brisk,
  cool,
  mild,
  perfect,
  warm,
  hot,
  scorching,
  none
}

extension clothTemperatureExtension on bestWeathersTemperatureForCloth {
  static const clothTemperatures = {
    bestWeathersTemperatureForCloth.freezing: -10,
    bestWeathersTemperatureForCloth.cold: 0,
    bestWeathersTemperatureForCloth.chilly: 4,
    bestWeathersTemperatureForCloth.brisk: 8,
    bestWeathersTemperatureForCloth.cool: 13,
    bestWeathersTemperatureForCloth.mild: 18,
    bestWeathersTemperatureForCloth.perfect: 25,
    bestWeathersTemperatureForCloth.warm: 29,
    bestWeathersTemperatureForCloth.hot: 33,
    bestWeathersTemperatureForCloth.scorching: 40,
  };

  int get clothTemperature => clothTemperatures[this];
}

class ClothingChooser extends ChangeNotifier {
  List<Clothing> proposals = [];
  bool _notEnoughData = false;
  bool get notEnoughData => _notEnoughData;
  void chooseClothing(
      List<QueryDocumentSnapshot> headwear,
      List<QueryDocumentSnapshot> tops,
      List<QueryDocumentSnapshot> bottoms,
      List<QueryDocumentSnapshot> footwear,
      List<QueryDocumentSnapshot> costumes,
      double allDayAverageTemperature,
      List<bool> additionalConditions) {
    List<QueryDocumentSnapshot> prefHeadwear = headwear
        .where((hat) =>
            (bestWeathersTemperatureForCloth
                        .values[hat['temperature'].toInt()].clothTemperature -
                    allDayAverageTemperature)
                .abs() <
            10)
        .toList();
    List<QueryDocumentSnapshot> prefCostumes = costumes
        .where((costume) =>
            (bestWeathersTemperatureForCloth
                        .values[costume['temperature'].toInt()]
                        .clothTemperature -
                    allDayAverageTemperature)
                .abs() <
            10)
        .toList();
    List<QueryDocumentSnapshot> prefFootwear = footwear
        .where((shoes) =>
            (bestWeathersTemperatureForCloth
                        .values[shoes['temperature'].toInt()].clothTemperature -
                    allDayAverageTemperature)
                .abs() <
            10)
        .toList();
    List<QueryDocumentSnapshot> prefTops = tops
        .where((top) =>
            (bestWeathersTemperatureForCloth
                        .values[top['temperature'].toInt()].clothTemperature -
                    allDayAverageTemperature)
                .abs() <
            10)
        .toList();
    List<QueryDocumentSnapshot> prefBottoms = bottoms
        .where((bottom) =>
            (bestWeathersTemperatureForCloth
                        .values[bottom['temperature'].toInt()]
                        .clothTemperature -
                    allDayAverageTemperature)
                .abs() <
            10)
        .toList();
    if (prefCostumes.isEmpty) {
      if (prefHeadwear.isEmpty ||
          prefTops.isEmpty ||
          prefBottoms.isEmpty ||
          prefFootwear.isEmpty) {
        _notEnoughData = true;
      } else {
        proposals.add(new Clothing(prefHeadwear[0], prefTops[0], prefBottoms[0],
            prefFootwear[0], false));
      }
    } else {
      if (prefHeadwear.isNotEmpty && prefFootwear.isNotEmpty) {
        proposals.add(new Clothing(
            prefHeadwear[0], prefCostumes[0], null, prefFootwear[0], true));
      } else {
        _notEnoughData = true;
      }
    }
    proposals.add(
        new Clothing(headwear[0], tops[0], bottoms[0], footwear[0], false));
    notifyListeners();
  }
}
