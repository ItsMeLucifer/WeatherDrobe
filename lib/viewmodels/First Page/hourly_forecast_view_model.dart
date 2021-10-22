import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherdrobe/services/webservice.dart';
import 'package:weatherdrobe/viewmodels/First Page/hour_view_model.dart';

class HourlyForecastViewModel extends ChangeNotifier {
  //HourlyForecastViewModel(this._lat, this._long);
  List<String> ikony = List<String>();
  List<HourViewModel> _hours = [];
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
    lat = _currentPosition.latitude;
    long = _currentPosition.longitude;
    //lat = 54.519974;
    //long = 18.551115;
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
    hours.remove(0);
    icons.remove(0);
    getFirstHourWithHighPropabilityOfPrecipitation();
  }

  List<double> temperatures = [];
  List<double> weatherIds = [];
  void getTemperaturesAndWeatherIds(int amount) {
    int tempCounter = 0;
    hours.forEach((hour) => {
          tempCounter++,
          if (tempCounter < amount)
            {
              temperatures.add(hour.temperature),
              weatherIds.add(hour.weatherId.toDouble())
            }
        });
  }

  //ACCESSORIES PROPOSAL
  HourViewModel _firstHourWithRain;
  HourViewModel get firstHourWithRain => _firstHourWithRain;

  double _averageProbabilityOfPrecipitation;
  double get averageProbabilityOfPrecipitation =>
      _averageProbabilityOfPrecipitation;

  void getFirstHourWithHighPropabilityOfPrecipitation() {
    int amountOfHoursToCheck = 15;
    double probOfPrecip = 0;
    bool gotAnHour = false;
    for (int i = 0; i < amountOfHoursToCheck; i++) {
      probOfPrecip += hours[i].propability;
      if (hours[i].propability > 0.25 && !gotAnHour) {
        _firstHourWithRain = hours[i];
        gotAnHour = true;
      }
    }
    _averageProbabilityOfPrecipitation = probOfPrecip / amountOfHoursToCheck;
  }
}
