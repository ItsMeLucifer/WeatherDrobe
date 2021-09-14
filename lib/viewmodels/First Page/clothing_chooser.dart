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

  Map<String, bool> _additionalConditions = {
    'Rain': false,
    'Snow': false,
    'Wind': false,
    'Sun': false
  };
  void chooseClothing(
      List<QueryDocumentSnapshot> headwear,
      List<QueryDocumentSnapshot> tops,
      List<QueryDocumentSnapshot> bottoms,
      List<QueryDocumentSnapshot> footwear,
      List<QueryDocumentSnapshot> costumes,
      double allDayAverageTemperature,
      int additionalConditions,
      //rain snow wind sun
      bool getMoreModels) {
    if (!getMoreModels) {
      if (proposals.isNotEmpty) return;
      _additionalConditions = _checkAdditionalConditions(additionalConditions);
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
    notifyListeners();
  }

  int _pickMin(List<int> array) {
    array.sort((a, b) => a - b);
    return array[0];
  }

//RAIN: 200 - 531
//SNOW: 600 - 622
//WIND: 781, 771
//SUN: 800
  Map<String, bool> _checkAdditionalConditions(int additionalConditions) {
    //poprawic na const wartosci
    if (200 <= additionalConditions && additionalConditions <= 531) {
      //return {"Rain": true, "Snow": false, "Wind": false, "Sun": false};
      return {"rain": true};
    }
    if (600 <= additionalConditions && additionalConditions <= 622) {
      return {"snow": true};
    }
    if (additionalConditions == 781 && additionalConditions == 771) {
      return {"wind": true};
    }
    if (additionalConditions == 800) {
      return {"sun": true};
    }
    return {};
  }

  Clothing _createModel() {
    List<QueryDocumentSnapshot> temporaryVault = [];
    Map<String, int> prefIndex = {
      'Headwear': 0,
      'Tops': 0,
      'Bottoms': 0,
      'Footwear': 0,
      'Costumes': 0
    };
    if (_additionalConditions.isNotEmpty) {
      _additionalConditions.forEach((key, value) {
        int counter = 0;
        _prefHeadwear.forEach((headwear) {
          if (headwear['$key'] == true) {
            prefIndex['Headwear'] = counter;
          }
          counter++;
        });
        counter = 0;
        _prefTops.forEach((top) {
          if (top['$key'] == true) {
            prefIndex['Tops'] = counter;
          }
          counter++;
        });
        counter = 0;
        _prefBottoms.forEach((bottom) {
          if (bottom['$key'] == true) {
            prefIndex['Bottoms'] = counter;
          }
          counter++;
        });
        counter = 0;
        _prefFootwear.forEach((footwear) {
          if (footwear['$key'] == true) {
            prefIndex['Footwear'] = counter;
          }
          counter++;
        });
        counter = 0;
        _prefCostumes.forEach((costume) {
          if (costume['$key'] == true) {
            prefIndex['Costumes'] = counter;
          }
          counter++;
        });
      });
    }
    if (_prefCostumes.isNotEmpty) {
      temporaryVault = [
        _prefHeadwear[prefIndex['Headwear']],
        _prefCostumes[prefIndex['Costumes']],
        _prefFootwear[prefIndex['Footwear']]
      ];
      _prefHeadwear.remove(prefIndex['Headwear']);
      _prefCostumes.remove(prefIndex['Costumes']);
      _prefFootwear.remove(prefIndex['Footwear']);
      return new Clothing(
          temporaryVault[0], temporaryVault[1], null, temporaryVault[2], true);
    }
    temporaryVault = [
      _prefHeadwear[prefIndex['Headwear']],
      _prefTops[prefIndex['Tops']],
      _prefBottoms[prefIndex['Bottoms']],
      _prefFootwear[prefIndex['Footwear']]
    ];
    _prefHeadwear.removeAt(prefIndex['Headwear']);
    _prefTops.removeAt(prefIndex['Tops']);
    _prefBottoms.removeAt(prefIndex['Bottoms']);
    _prefFootwear.removeAt(prefIndex['Footwear']);
    return new Clothing(temporaryVault[0], temporaryVault[1], temporaryVault[2],
        temporaryVault[3], false);
  }
}
