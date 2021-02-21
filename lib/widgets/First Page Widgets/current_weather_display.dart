import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/viewmodels/First Page VM/hour_view_model.dart';
import 'package:weatherdrobe/widgets/First Page Widgets/hourly_forecast_list_display.dart';

class CurrentWeatherDisplay extends ConsumerWidget {
  Future<void> setJiffyLocale() async {
    await Jiffy.locale("en");
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cdvm = watch(currentData);
    double dividersWidth = 10;
    setJiffyLocale();
    return GestureDetector(
      onTap: () => cdvm.onTap = cdvm.onTap ? false : true,
      child: Stack(children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.teal[800], width: 1),
          ),
          child: Column(children: [
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: dividersWidth, height: 1),
                    Column(children: [
                      Text(
                        firstCapital(Jiffy().format("EEEE").toString()),
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Jiffy().format("d.MM").toString(),
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Container(width: 25, height: 1),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(children: [
                        Container(
                          child: Text(
                            firstCapital(cdvm.description ?? "clouds"),
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            (cdvm.temperature.toString() ?? "10.5") + "°C",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Container(
                        width: 60,
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
                    Container(width: dividersWidth, height: 1),
                  ]),
              padding: EdgeInsets.only(top: 20, bottom: 12),
            ),
            cdvm.onTap ? HourlyForecastListDisplay() : Container(),
          ]),
          color: Colors.teal[800],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 85.0, left: 4, right: 4),
            child: Container(
              width: 500,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.teal[800],
              ),
            )),
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
