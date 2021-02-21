class UrlHelper {
  static String urlForWeatherAPI(double latitude, double longitude) {
    return "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&appid=fe9216376911ed3e4b7a8518b305087d";
  }

  static String urlForWeatherIcon(String iconId) {
    return "http://openweathermap.org/img/wn/$iconId@2x.png";
  }
}
