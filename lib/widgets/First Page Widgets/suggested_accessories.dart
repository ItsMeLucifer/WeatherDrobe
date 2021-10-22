import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../main.dart';

class SuggestedAccessories extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tools = watch(toolsVM);
    final hfvm = watch(hourlyData);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        hfvm.firstHourWithRain != null
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
                              hfvm.firstHourWithRain.propability) +
                          "%",
                      style: TextStyle(
                          color: tools.textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: tools.fontFamily),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: 75),
                  ),
                  Container(
                    child: Text(
                      '🌂',
                      style: tools.optionStyle,
                    ),
                    padding: EdgeInsets.all(30),
                  ),
                ]),
                color: tools.primaryColor,
              )
            : Container(),
      ],
    );
  }
}