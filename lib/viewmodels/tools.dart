import 'package:flutter/cupertino.dart';

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
  }

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
}
