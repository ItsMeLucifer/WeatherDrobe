import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class HourlyForecastListDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final hfvm = watch(hourlyData);
    final tools = watch(toolsVM);
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
                  //STWORZYC FUNKCJE, KTORA USTAWI DLUGOSC WEATHER DESCRIPTION ZAWSZENA TAKĄ SAMĄ(dodajac spacje i ewentualnie usuwajac slowa).
                  "" +
                      tools.unixToLocalTimeConverter(hour.time) +
                      " 🕒    ${tools.fixTemperatureDisplay(hour.temperature)}°C🌡️    ${tools.fixedPropPercents(hour.propability, true)}% ☔${tools.setStringLengthToConstantValue(hour.description, 15)}",
                  style: TextStyle(fontSize: 14, color: tools.textColor)),
            ),
            color: tools.secondaryColor,
          );
        },
      ),
    );
  }
}
