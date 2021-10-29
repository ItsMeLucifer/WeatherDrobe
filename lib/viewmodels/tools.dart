import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Tools extends ChangeNotifier {
  double calculateTheMedian(List<double> hours) {
    hours.sort();
    if (hours.isNotEmpty) {
      if (hours.length % 2 == 0) {
        return (hours[hours.length ~/ 2] + hours[-1 + hours.length ~/ 2]) / 2;
      } else {
        return hours[hours.length ~/ 2];
      }
    }
    return 0.0;
  }

  //Cosmetics
  //Color get primaryColor => Color.fromRGBO(200, 200, 200, 1);
  Color get primaryColor => Color.fromRGBO(0, 0, 0, 0.6);
  //Color get secondaryColor => Color.fromRGBO(220, 220, 220, 1);
  Color get secondaryColor => Color.fromRGBO(0, 0, 0, 0.4);
  //Color get tetriaryColor => Color.fromRGBO(240, 240, 240, 1);
  Color get tetriaryColor => Color.fromRGBO(0, 0, 0, 0.3);
  Color get quaternaryColor => Color.fromRGBO(0, 0, 0, 0.25);
  //Color get quinaryColor => Color.fromRGBO(0, 0, 0, 0.5);
  Color get disabledText => Color.fromRGBO(255, 255, 255, 0.5);
  Color get disabledColor => Color.fromRGBO(255, 200, 200, 0.5);
  Color get textColor => Colors.white;
  Color get textSecondaryColor => Colors.black;
  String get fontFamily => 'Nexa';
  TextStyle get optionStyle => TextStyle(fontSize: 30);
  //--Cloth Creator
  Color get borderColor => Color.fromRGBO(72, 67, 73, 0.3);
  dynamic get outline => [
        Shadow(
            // bottomLeft
            offset: Offset(-1, -1),
            color: Colors.black),
        Shadow(
            // bottomRight
            offset: Offset(1, -1),
            color: Colors.black),
        Shadow(
            // topRight
            offset: Offset(1, 1),
            color: Colors.black),
        Shadow(
            // topLeft
            offset: Offset(-1, 1),
            color: Colors.black),
      ];
  double _screenWidth;
  double get screenWidth => _screenWidth;
  set screenWidth(double value) {
    _screenWidth = value;
    notifyListeners();
  }

  double _screenHeight;
  double get screenHeight => _screenHeight;
  set screenHeight(double value) {
    _screenHeight = value;
    notifyListeners();
  }

  String fixedPropPercents(double prop, bool withSpaces) {
    prop *= 100;
    String result = prop.toStringAsFixed(0);
    if (!withSpaces) return result;
    if (result.length == 1) {
      return ("    " + result);
    } else if (result.length == 2) {
      return ("  " + result);
    }
    return result;
  }

  String fixDescription(String s, int length) {
    if (s.length > length) {
      var splitted = s.split(" ");
      s = splitted[splitted.length - 2] + " " + splitted[splitted.length - 1];
      if (s.length > length) s = splitted[splitted.length - 1];
    }
    return ("${s[0].toUpperCase()}${s.substring(1)}");
  }

  String setStringLengthToConstantValue(String s, int constantValue) {
    if (s.length > constantValue) {
      var splitted = s.split(" ");
      s = splitted[splitted.length - 1];
    }
    s = firstCapital(s);
    while (s.length <= constantValue) {
      s = "  " + s;
    }
    return s;
  }

  String firstCapital(String s) {
    return ("${s[0].toUpperCase()}${s.substring(1)}");
  }

  String unixToLocalTimeConverter(int unix) {
    return Jiffy(Jiffy.unix(unix)).format("HH:mm").toString();
  }

  String fixTemperatureDisplay(double temperature) {
    String temp = temperature.toStringAsFixed(0);
    if (temp.length != 2) {
      return "  " + temp;
    }
    return temp;
  }

  //Cloth Creator
  int _pageNumber = 0;
  int get pageNumber => _pageNumber;
  set pageNumber(int value) {
    _pageNumber = value;
    notifyListeners();
  }

  final controller = PageController(
    initialPage: 0,
  );
}
