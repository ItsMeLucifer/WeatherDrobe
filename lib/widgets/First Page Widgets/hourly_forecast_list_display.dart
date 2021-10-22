import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weatherdrobe/main.dart';

class HourlyForecastListDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final hfvm = watch(hourlyData);
    final tools = watch(toolsVM);
    print(hfvm.hours[0].hourly.time.toString());
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: hfvm.hours.length > 15 ? 15 : hfvm.hours.length,
        itemBuilder: (context, index) {
          final hour = hfvm.hours[index];
          return Card(
            child: ListTile(
              trailing: Container(
                  height: 40,
                  width: 40,
                  child: hfvm.icons[index]
                                  .substring(0, hfvm.icons[index].length - 1) ==
                              "13" ||
                          hfvm.icons[index]
                                  .substring(0, hfvm.icons[index].length - 1) ==
                              "50"
                      ? Image(
                          image: NetworkImage(hfvm.icons[index] ??
                              "http://openweathermap.org/img/wn/03d.png"))
                      : Image(
                          image: NetworkImage(hfvm.icons[index] ??
                              "http://openweathermap.org/img/wn/03d.png"))),
              title: Text(
                  "" +
                      tools.unixToLocalTimeConverter(hour.time) +
                      " 🕒    ${cutTheTemperature(hour.temperature)}°C🌡️    ${tools.fixedPropPercents(hour.propability)}% ☔       ${firstCapital(hour.description)}",
                  style: TextStyle(fontSize: 14, color: tools.textColor)),
            ),
            color: tools.secondaryColor,
          );
        },
      ),
    );
  }

  String cutTheTemperature(double temperature) {
    return temperature.toStringAsFixed(0);
  }

  String firstCapital(String s) {
    return ("${s[0].toUpperCase()}${s.substring(1)}");
  }
}
