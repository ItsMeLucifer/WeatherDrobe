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
  List<QueryDocumentSnapshot> _prefHeadwear = [];
  List<QueryDocumentSnapshot> _prefCostumes = [];
  List<QueryDocumentSnapshot> _prefFootwear = [];
  List<QueryDocumentSnapshot> _prefTops = [];
  List<QueryDocumentSnapshot> _prefBottoms = [];
  int amountOfFreeClothing = 0;
  int _currentModelIndex = 0;
  int get currentModelIndex => _currentModelIndex;
  set currentModelIndex(int value) {
    _currentModelIndex = value;
    notifyListeners();
  }

  void chooseClothing(
      List<QueryDocumentSnapshot> headwear,
      List<QueryDocumentSnapshot> tops,
      List<QueryDocumentSnapshot> bottoms,
      List<QueryDocumentSnapshot> footwear,
      List<QueryDocumentSnapshot> costumes,
      double allDayAverageTemperature,
      List<bool> additionalConditions,
      bool getMoreModels) {
    if (!getMoreModels) {
      if (proposals.isNotEmpty) return;
      _prefHeadwear = headwear
          .where((hat) =>
              (bestWeathersTemperatureForCloth
                          .values[hat['temperature'].toInt()].clothTemperature -
                      allDayAverageTemperature)
                  .abs() <
              10)
          .toList();
      _prefCostumes = costumes
          .where((costume) =>
              (bestWeathersTemperatureForCloth
                          .values[costume['temperature'].toInt()]
                          .clothTemperature -
                      allDayAverageTemperature)
                  .abs() <
              10)
          .toList();
      _prefFootwear = footwear
          .where((shoes) =>
              (bestWeathersTemperatureForCloth
                          .values[shoes['temperature'].toInt()]
                          .clothTemperature -
                      allDayAverageTemperature)
                  .abs() <
              10)
          .toList();
      _prefTops = tops
          .where((top) =>
              (bestWeathersTemperatureForCloth
                          .values[top['temperature'].toInt()].clothTemperature -
                      allDayAverageTemperature)
                  .abs() <
              10)
          .toList();
      _prefBottoms = bottoms
          .where((bottom) =>
              (bestWeathersTemperatureForCloth
                          .values[bottom['temperature'].toInt()]
                          .clothTemperature -
                      allDayAverageTemperature)
                  .abs() <
              10)
          .toList();
      print('prefss: ' + _prefBottoms[0]['dir'] + _prefBottoms[1]['dir']);
    }
    amountOfFreeClothing = _pickMin([
      _prefTops.length,
      _prefBottoms.length,
      _prefFootwear.length,
      _prefHeadwear.length,
    ]);
    int _amountOfModels = 0;
    while (amountOfFreeClothing > 0) {
      proposals.add(_createModel());
      amountOfFreeClothing--;
      _amountOfModels++;
      if (_amountOfModels > 2) break;
    }
    print('diff' + proposals[0].bottom['dir'] + proposals[1].bottom['dir']);
    notifyListeners();
  }

  int _pickMin(List<int> array) {
    array.sort((a, b) => a - b);
    return array[0];
  }

  Clothing _createModel() {
    List<QueryDocumentSnapshot> temporaryVault = [];
    if (_prefCostumes.isNotEmpty) {
      temporaryVault = [_prefHeadwear[0], _prefCostumes[0], _prefFootwear[0]];
      _prefHeadwear.remove(0);
      _prefCostumes.remove(0);
      _prefFootwear.remove(0);
      print('COSTUME');
      return new Clothing(
          temporaryVault[0], temporaryVault[1], null, temporaryVault[2], true);
    }
    temporaryVault = [
      _prefHeadwear[0],
      _prefTops[0],
      _prefBottoms[0],
      _prefFootwear[0]
    ];
    print('added: ' +
        _prefHeadwear[0]['dir'] +
        ' ' +
        _prefTops[0]['dir'] +
        ' ' +
        _prefBottoms[0]['dir'] +
        ' ' +
        _prefFootwear[0]['dir']);
    _prefHeadwear.remove(0);
    _prefTops.remove(0);
    _prefBottoms.remove(0);
    _prefFootwear.remove(0);

    return new Clothing(temporaryVault[0], temporaryVault[1], temporaryVault[2],
        temporaryVault[3], false);
  }
}
