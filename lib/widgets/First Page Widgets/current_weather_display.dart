import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/viewmodels/First Page/hour_view_model.dart';
import 'package:weatherdrobe/widgets/First Page Widgets/hourly_forecast_list_display.dart';

class CurrentWeatherDisplay extends ConsumerWidget {
  Future<void> setJiffyLocale() async {
    await Jiffy.locale("en_US");
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cdvm = watch(currentData);
    final tools = watch(toolsVM);
    setJiffyLocale();
    return GestureDetector(
      onTap: () => cdvm.onTap = cdvm.onTap ? false : true,
      child: Stack(children: [
        Card(
          child: Container(
            child: Column(children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Text(
                          firstCapital(Jiffy().format("EEEE").toString()),
                          style: TextStyle(
                              color: tools.textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: tools.fontFamily),
                        ),
                        Text(
                          Jiffy().format("d.MM").toString(),
                          style: TextStyle(
                              color: tools.textColor,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontFamily: tools.fontFamily),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(children: [
                          Container(
                            child: Text(
                              //firstCapital(cdvm.description ?? "clouds"),
                              fixDescription(cdvm.description ?? "clouds"),
                              style: TextStyle(
                                  color: tools.textColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: tools.fontFamily),
                            ),
                          ),
                          Container(
                            child: Text(
                              (cdvm.temperature.toString() ?? "10.5") + "°C",
                              style: TextStyle(
                                  color: tools.textColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: tools.fontFamily),
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          width: 50,
                          height: 60,
                          child: (cdvm.iconId != null
                                          ? cdvm.iconId.substring(
                                              0, cdvm.iconId.length - 1)
                                          : "5") ==
                                      "13" ||
                                  (cdvm.iconId != null
                                          ? cdvm.iconId.substring(
                                              0, cdvm.iconId.length - 1)
                                          : "5") ==
                                      "50"
                              ? ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black, BlendMode.modulate),
                                  child: Image(
                                      image: NetworkImage(cdvm.iconUrl ??
                                          "http://openweathermap.org/img/wn/03d.png")),
                                )
                              : Image(
                                  image: NetworkImage(cdvm.iconUrl ??
                                      "http://openweathermap.org/img/wn/03d.png")),
                        ),
                      ),
                    ]),
                padding: EdgeInsets.only(top: 20, bottom: 12),
              ),
              cdvm.onTap
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: HourlyForecastListDisplay(),
                    )
                  : Container(),
            ]),
          ),
          color: tools.primaryColor,
        ),
      ]),
    );
  }

  Future<Widget> hourlyForecast() async {
    await Future.delayed(const Duration(milliseconds: 100), () {});
    return HourlyForecastListDisplay();
  }

  String firstCapital(String s) {
    return ("${s[0].toUpperCase()}${s.substring(1)}");
  }

  String fixDescription(String s) {
    if (s.length > 18) {
      var splitted = s.split(" ");
      s = splitted[splitted.length - 2] + " " + splitted[splitted.length - 1];
      if (s.length > 18) s = splitted[splitted.length - 1];
    }
    return ("${s[0].toUpperCase()}${s.substring(1)}");
  }

  String fixedPropPercents(List<HourViewModel> prop) {
    String result;
    for (int i = 0; i < prop.length; i++) {
      double temp = 0;
      if (prop[i].propability > temp) {
        result = (prop[i].propability * 100).toStringAsFixed(0);
      }
    }
    return result;
  }
}
