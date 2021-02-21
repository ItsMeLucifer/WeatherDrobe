import 'dart:convert';
import 'package:weatherdrobe/models/current_data.dart';
import 'package:weatherdrobe/models/hourly_forecast.dart';
import 'package:weatherdrobe/utilities/url_helper.dart';
import 'package:http/http.dart' as http;

class Webservice {
  Future<dynamic> fetchCurrentData(double latitude, double longitude) async {
    final url = UrlHelper.urlForWeatherAPI(latitude, longitude);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse["current"];
      final apiData = CurrentData.fromJson(result);
      return apiData;
    } else {
      throw Exception("Failed to fetch current data");
    }
  }

  Future<dynamic> fetchHourlyForecast(double latitude, double longitude) async {
    final url = UrlHelper.urlForWeatherAPI(latitude, longitude);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final Iterable results = jsonResponse["hourly"];
      return results.map((hour) => HourlyForecast.fromJson(hour)).toList();
    } else {
      throw Exception("Failed to fetch Hourly Forecast");
    }
  }

  Future<String> fetchIconId(String iconId) async {
    final url = UrlHelper.urlForWeatherIcon(iconId);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return url;
    } else {
      throw Exception("Failed to fetch Icon");
    }
  }
}
