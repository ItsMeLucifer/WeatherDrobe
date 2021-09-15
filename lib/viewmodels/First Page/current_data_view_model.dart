import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherdrobe/services/webservice.dart';

class CurrentDataViewModel extends ChangeNotifier {
  String _iconId;
  String get iconId => _iconId;
  set iconId(String value) {
    _iconId = value;
    notifyListeners();
  }

  dynamic _time;
  dynamic get time => _time;
  set time(dynamic value) {
    _time = value;
    notifyListeners();
  }

  String _description;
  String get description => _description;
  set description(String value) {
    _description = value;
    notifyListeners();
  }

  double _temperature;
  double get temperature => _temperature;
  set temperature(double value) {
    _temperature = value;
    notifyListeners();
  }

  String _iconUrl;
  String get iconUrl => _iconUrl;
  set iconUrl(String value) {
    _iconUrl = value;
    notifyListeners();
  }

  bool _onTap = false;
  bool get onTap => _onTap;
  set onTap(bool value) {
    _onTap = value;
    notifyListeners();
  }

  double _lat;
  double get lat => _lat;
  set lat(double value) {
    _lat = value;
    notifyListeners();
  }

  double _long;
  double get long => _long;
  set long(double value) {
    _long = value;
    notifyListeners();
  }

  Future<void> getCurrentPosition() async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = _currentPosition.latitude;
    long = _currentPosition.longitude;
    lat = 54.519974;
    long = 18.551115;
    fetchCurrentData();
  }

  Future<void> fetchCurrentData() async {
    final resultFromWebservice = await Webservice().fetchCurrentData(lat, long);
    iconId = resultFromWebservice.iconId;
    temperature = resultFromWebservice.temperature;
    description = resultFromWebservice.description;
    time = resultFromWebservice.time;
    fetchWeatherIcon();
  }

  Future<void> fetchWeatherIcon() async {
    String resultFromWebservice = await Webservice().fetchIconId(iconId);
    iconUrl = resultFromWebservice;
  }
}
