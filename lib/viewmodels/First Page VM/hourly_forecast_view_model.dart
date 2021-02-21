import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherdrobe/services/webservice.dart';
import 'package:weatherdrobe/viewmodels/First Page VM/hour_view_model.dart';

class HourlyForecastViewModel extends ChangeNotifier {
  //HourlyForecastViewModel(this._lat, this._long);
  List<String> ikony = List<String>();
  List<HourViewModel> _hours;
  List<HourViewModel> get hours => _hours;
  set hours(List<HourViewModel> value) {
    _hours = value;
    notifyListeners();
  }

  List<String> _icons;
  List<String> get icons => _icons;
  set icons(List<String> value) {
    _icons = value;
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
    // lat = _currentPosition.latitude;
    // long = _currentPosition.longitude;
    lat = 54.519974;
    long = 18.551115;
    getHourlyData();
  }

  Future<void> getHourlyData() async {
    final Iterable results = await Webservice().fetchHourlyForecast(lat, long);
    hours = results.map((hour) => HourViewModel(hourly: hour)).toList();
    fetchHourlyIcon();
  }

  Future<void> fetchHourlyIcon() async {
    hours.forEach((element) async {
      String resultFromWebservice =
          await Webservice().fetchIconId(element.iconId);
      ikony.add(resultFromWebservice);
    });
    icons = ikony;
  }
}
