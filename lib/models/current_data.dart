class CurrentData {
  final String iconId;
  final double temperature;
  final String description;
  final dynamic time;

  CurrentData({this.iconId, this.temperature, this.description, this.time});
  factory CurrentData.fromJson(dynamic json) {
    return CurrentData(
        iconId: json["weather"][0]["icon"],
        temperature: json["temp"].toDouble(),
        description: json["weather"][0]["description"],
        time: json["dt"]);
  }
}
