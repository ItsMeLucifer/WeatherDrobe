class HourlyForecast {
  final String iconId;
  final double temperature;
  final String description;
  final double propabilityOfPrecipitation;
  final int time;
  final int weatherId;
  final double windSpeed;

  HourlyForecast(
      {this.iconId,
      this.temperature,
      this.description,
      this.propabilityOfPrecipitation,
      this.time,
      this.weatherId,
      this.windSpeed});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
        iconId: json["weather"][0]["icon"],
        temperature: json["temp"].toDouble(),
        description: json["weather"][0]["description"],
        propabilityOfPrecipitation: json["pop"].toDouble(),
        time: json["dt"],
        weatherId: json["weather"][0]["id"],
        windSpeed: json["wind_speed"].toDouble());
  }
}
