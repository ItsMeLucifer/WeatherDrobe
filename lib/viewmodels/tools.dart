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
  Color get primaryColor => Color.fromRGBO(0, 0, 0, 0.2);
  //Color get secondaryColor => Color.fromRGBO(220, 220, 220, 1);
  Color get secondaryColor => Color.fromRGBO(0, 0, 0, 0.05);
  //Color get tetriaryColor => Color.fromRGBO(240, 240, 240, 1);
  Color get tetriaryColor => Color.fromRGBO(0, 0, 0, 0.3);
  Color get quaternaryColor => Color.fromRGBO(0, 0, 0, 0.5);
  //Color get quinaryColor => Color.fromRGBO(0, 0, 0, 0.5);
  Color get disabledColor => Color.fromRGBO(255, 200, 200, 0.5);
  Color get textColor => Colors.white;
  String get fontFamily => 'Nexa';
  TextStyle get optionStyle => TextStyle(fontSize: 30);
  //--Cloth Creator
  Color get borderColor => Color.fromRGBO(72, 67, 73, 0.3);

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

  String fixedPropPercents(double prop) {
    prop *= 100;
    String result = prop.toStringAsFixed(0);
    if (result.length == 1) {
      return ("    " + result);
    } else if (result.length == 2) {
      return ("  " + result);
    }
    return result;
  }

  String unixToLocalTimeConverter(int unix) {
    return Jiffy(Jiffy.unix(unix)).format("HH:mm").toString();
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
