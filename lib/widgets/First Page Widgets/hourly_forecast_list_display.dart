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
        itemCount: hfvm.hours.length > hfvm.numberOfHoursAnalysed
            ? hfvm.numberOfHoursAnalysed
            : hfvm.hours.length,
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
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tools.unixToLocalTimeConverter(hour.time),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: tools.textColor)),
                  Row(
                    children: [
                      Text(
                          "${tools.fixTemperatureDisplay(hour.temperature)}°C🌡️  ",
                          style:
                              TextStyle(fontSize: 14, color: tools.textColor)),
                      Text(
                          "${tools.fixedPropPercents(hour.propability, true)}% ☔",
                          style:
                              TextStyle(fontSize: 14, color: tools.textColor)),
                    ],
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      "${tools.setStringLengthToConstantValue(hour.description, 14)}",
                      style: TextStyle(fontSize: 14, color: tools.textColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            color: tools.secondaryColor,
          );
        },
      ),
    );
  }
}
