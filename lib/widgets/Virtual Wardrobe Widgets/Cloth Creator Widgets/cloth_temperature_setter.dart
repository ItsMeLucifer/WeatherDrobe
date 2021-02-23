import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothTemperatureSetter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    Color textColor = Colors.black;
    // Color secondaryColor = Color.fromRGBO(0, 121, 140, 1);
    Color secondaryColor = Colors.black;
    Color thirdColor = Color.fromRGBO(81, 163, 163, 0.5);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 5),
            child: Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cloth Creator',
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
            padding: const EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose which outside temperature is best for this cloth",
                style: TextStyle(
                    fontSize: 15, color: textColor, fontFamily: 'Nexa'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 15),
            child: Center(
                child: Text(vwvm.temperature(vwvm.temperatureRating),
                    style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.bold))),
          ),
          Slider(
            value: vwvm.temperatureRating,
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: secondaryColor,
            inactiveColor: thirdColor,
            onChanged: (double value) {
              vwvm.temperatureRating = value;
            },
          ),
        ],
      ),
    );
  }
}
