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

  int _numberOfHoursAnalysed = 15;
  int get numberOfHoursAnalysed => _numberOfHoursAnalysed;
  set numberOfHoursAnalysed(int value) {
    _numberOfHoursAnalysed = value;
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
  void getTemperaturesAndWeatherIds() {
    int tempCounter = 0;
    hours.forEach((hour) => {
          tempCounter++,
          if (tempCounter < numberOfHoursAnalysed)
            {
              temperatures.add(hour.temperature),
              weatherIds.add(hour.weatherId.toDouble())
            }
        });
  }

  //ACCESSORIES PROPOSAL
  HourViewModel _firstHourWithRain;
  HourViewModel get firstHourWithRain => _firstHourWithRain;

  HourViewModel _firstHourForHat;
  HourViewModel get firstHourForHat => _firstHourForHat;

  HourViewModel _firstHourForGloves;
  HourViewModel get firstHourForGloves => _firstHourForGloves;

  HourViewModel _firstHourForScarf;
  HourViewModel get firstHourForScarf => _firstHourForScarf;

  double _averageProbabilityOfPrecipitation;
  double get averageProbabilityOfPrecipitation =>
      _averageProbabilityOfPrecipitation;

  double _averageTemperature;
  double get averageTemperature => _averageTemperature;

  double _averageWindSpeed;
  double get averageWindSpeed => _averageWindSpeed;

  void getFirstHourWithHighPropabilityOfPrecipitation() {
    double probOfPrecip = 0;
    double sumOfTemperatures = 0;
    double sumOfWindSpeed = 0;
    bool test = true;
    for (int i = 0; i < numberOfHoursAnalysed; i++) {
      probOfPrecip += hours[i].propability;
      sumOfTemperatures += hours[i].temperature;
      sumOfWindSpeed += hours[i].windSpeed;
      if (hours[i].propability > 0.25 && firstHourWithRain == null || test)
        _firstHourWithRain = hours[i];
      if (hours[i].temperature < 10 && firstHourForHat == null || test)
        _firstHourForHat = hours[i];
      if (hours[i].temperature < 0 && firstHourForGloves == null || test)
        _firstHourForGloves = hours[i];
      if (hours[i].windSpeed > 10 && firstHourForScarf == null || test)
        _firstHourForScarf = hours[i];
    }
    _averageProbabilityOfPrecipitation = probOfPrecip / numberOfHoursAnalysed;
    _averageTemperature = sumOfTemperatures / numberOfHoursAnalysed;
    _averageWindSpeed = sumOfWindSpeed / numberOfHoursAnalysed;
  }
}
