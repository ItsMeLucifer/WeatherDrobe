import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../main.dart';

class SuggestedAccessories extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tools = watch(toolsVM);
    final hfvm = watch(hourlyData);
    final Color tilesColor = tools.primaryColor;
    // if (hfvm.firstHourWithRain == null ||
    //     hfvm.firstHourForHat == null ||
    //     hfvm.firstHourForGloves == null ||
    //     hfvm.firstHourForScarf == null) return Container();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //UMBRELLA
        hfvm.firstHourWithRain != null &&
                hfvm.firstHourWithRain.time != null &&
                hfvm.averageProbabilityOfPrecipitation != null
            ? Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                        width: 100,
                        child: Text(
                          "Av.: " +
                              (hfvm.averageProbabilityOfPrecipitation * 100)
                                  .toStringAsFixed(0) +
                              "%",
                          style: TextStyle(
                              color: tools.textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: tools.fontFamily),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      tools.unixToLocalTimeConverter(
                              hfvm.firstHourWithRain.time) +
                          " - " +
                          tools.fixedPropPercents(
                              hfvm.firstHourWithRain.propability, false) +
                          "%",
                      style: TextStyle(
                          color: tools.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: tools.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 75),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, top: 23),
                    child: Container(
                        width: 45,
                        height: 45,
                        child: Image.asset('images/icons/umbrella.png')),
                  ),
                ]),
                color: tilesColor,
              )
            : Container(),
        //HAT
        hfvm.firstHourForHat != null && hfvm.firstHourForHat.time != null
            ? Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                        width: 100,
                        child: Text(
                          "Av.: " +
                              (hfvm.averageTemperature).toStringAsFixed(0) +
                              "°C",
                          style: TextStyle(
                              color: tools.textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: tools.fontFamily),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      tools.unixToLocalTimeConverter(
                              hfvm.firstHourForHat.time) +
                          " : " +
                          (hfvm.firstHourForHat.temperature)
                              .toStringAsFixed(0) +
                          "°C",
                      style: TextStyle(
                          color: tools.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: tools.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 75),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 23),
                    child: Container(
                      width: 60,
                      height: 60,
                      child: ColorFiltered(
                          colorFilter:
                              ColorFilter.mode(Colors.blue, BlendMode.modulate),
                          child: Image.asset(
                              'images/templates/headwear/winter-hat.png')),
                    ),
                  )
                ]),
                color: tilesColor,
              )
            : Container(),
        //GLOVES
        hfvm.firstHourForGloves != null && hfvm.firstHourForGloves.time != null
            ? Card(
                child: Stack(children: [
                  Container(
                    width: 100,
                    child: Text(
                      tools.unixToLocalTimeConverter(
                              hfvm.firstHourForGloves.time) +
                          " : " +
                          (hfvm.firstHourForGloves.temperature)
                              .toStringAsFixed(0) +
                          "°C",
                      style: TextStyle(
                          color: tools.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: tools.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 75),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, top: 20),
                    child: Container(
                      width: 45,
                      height: 45,
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.brown[100], BlendMode.modulate),
                          child: Image.asset('images/icons/winter-gloves.png')),
                    ),
                  )
                ]),
                color: tilesColor,
              )
            : Container(),
        //SCARF
        hfvm.firstHourForScarf != null && hfvm.firstHourForScarf.time != null
            ? Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                        width: 100,
                        child: Text(
                          "Av.: " +
                              (hfvm.averageWindSpeed).toStringAsFixed(0) +
                              " m/s",
                          style: TextStyle(
                              color: tools.textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: tools.fontFamily),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      tools.unixToLocalTimeConverter(
                              hfvm.firstHourForScarf.time) +
                          " - " +
                          (hfvm.firstHourForScarf.windSpeed)
                              .toStringAsFixed(0) +
                          " m/s",
                      style: TextStyle(
                          color: tools.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: tools.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 75),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27, top: 25),
                    child: Container(
                      width: 45,
                      height: 45,
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.yellow, BlendMode.modulate),
                          child: Image.asset('images/icons/scarf.png')),
                    ),
                  )
                ]),
                color: tilesColor,
              )
            : Container(),
      ],
    );
  }
}
