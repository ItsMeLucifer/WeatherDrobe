import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothTemperatureSetter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final tools = watch(toolsVM);
    Color activeSliderColor = Colors.black;
    Color inactiveSliderColor = Color.fromRGBO(81, 163, 163, 0.5);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 5),
            child: Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Outfit Creator',
                style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'Nexa',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Temperature',
                style: TextStyle(fontSize: 30, fontFamily: 'Nexa'),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 9),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What temeperature would you wear this piece of clothing in?",
                style: TextStyle(
                    fontSize: 15,
                    color: tools.textSecondaryColor,
                    fontFamily: 'Nexa'),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 15),
            child: Center(
                child: Text(vwvm.temperature(vwvm.temperatureRating),
                    style: TextStyle(
                        fontSize: 20,
                        color: tools.textSecondaryColor,
                        fontWeight: FontWeight.bold))),
          ),
          Slider(
            value: vwvm.temperatureRating,
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: activeSliderColor,
            inactiveColor: inactiveSliderColor,
            onChanged: (double value) {
              vwvm.temperatureRating = value;
            },
          ),
        ],
      ),
    );
  }
}
