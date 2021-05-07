import 'package:weatherdrobe/models/hourly_forecast.dart';

class HourViewModel {
  final HourlyForecast hourly;

  HourViewModel({this.hourly});

  String get iconId {
    return hourly.iconId;
  }

  double get temperature {
    return hourly.temperature;
  }

  String get description {
    return hourly.description;
  }

  double get propability {
    return hourly.propabilityOfPrecipitation;
  }

  int get time {
    return hourly.time;
  }

  int get weatherId {
    return hourly.weatherId;
  }
}
