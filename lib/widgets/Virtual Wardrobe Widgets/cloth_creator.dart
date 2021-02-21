import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/cloth_template_chooser.dart';

enum bestWeathersTemperatureForCloth {
  freezing,
  cold,
  chilly,
  brisk,
  cool,
  mild,
  perfect,
  warm,
  hot,
  scorching,
  none
}

extension clothTemperatureExtension on bestWeathersTemperatureForCloth {
  static const clothTemperatures = {
    bestWeathersTemperatureForCloth.freezing: -10,
    bestWeathersTemperatureForCloth.cold: 0,
    bestWeathersTemperatureForCloth.chilly: 4,
    bestWeathersTemperatureForCloth.brisk: 8,
    bestWeathersTemperatureForCloth.cool: 13,
    bestWeathersTemperatureForCloth.mild: 18,
    bestWeathersTemperatureForCloth.perfect: 25,
    bestWeathersTemperatureForCloth.warm: 29,
    bestWeathersTemperatureForCloth.hot: 33,
    bestWeathersTemperatureForCloth.scorching: 40,
  };

  int get clothTemperature => clothTemperatures[this];
}

enum additionalWeatherConditions { snow, rain, hail, wind, none }

// class ClothCreator extends StatefulWidget {
//   @override
//   _ClothCreator createState() => _ClothCreator();
// }

class ClothCreator extends ConsumerWidget {
  double iconSize = 30;
  double opacity = 0.3;
  double conditionsRating = 2;
  Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);
  Color primaryColor = Color.fromRGBO(72, 67, 73, 0.5);
  Color secondaryColor = Color.fromRGBO(0, 121, 140, 1);
  Color thirdColor = Color.fromRGBO(81, 163, 163, 0.5);
  Color borderColor = Color.fromRGBO(72, 67, 73, 0.3);
  Color textColor = Colors.black;
  double borderWidth = 3;
  Color buttonTextColor = Colors.white;

  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favw = watch(firebaseAuth);

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose a color'),
            content: SingleChildScrollView(
                child: Container(
                    child: ListBody(children: <Widget>[
              MaterialColorPicker(
                  allowShades: false, // default true
                  onMainColorChange: (ColorSwatch color) {
                    // Handle main color changes
                  },
                  selectedColor: Colors.red)
            ]))),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClothTemplateChooser()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Container(
                    width: 420,
                    height: 50,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border(
                            top: BorderSide(
                                color: borderColor, width: borderWidth),
                            bottom: BorderSide(
                                color: borderColor, width: borderWidth))),
                    child: Center(
                      child: Text('Template',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: buttonTextColor)),
                    )),
              )),
          GestureDetector(
              onTap: () {
                _showMyDialog();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    width: 420,
                    height: 50,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border(
                            top: BorderSide(
                                color: borderColor, width: borderWidth),
                            bottom: BorderSide(
                                color: borderColor, width: borderWidth))),
                    child: Center(
                        child: Text('Color',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: buttonTextColor)))),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Text(
              "Choose which outside temperature is best for this cloth",
              style: TextStyle(fontSize: 18, color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 7.5),
            child: Center(
                child: Text(temperature(vwvm.temperatureRating),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 0.0, bottom: 10),
              child: Text(
                  "Choose with what weather conditions this cloth is suitable",
                  style: TextStyle(fontSize: 18, color: textColor),
                  textAlign: TextAlign.center),
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.rain = !vwvm.rain;
            },
            child: Opacity(
              opacity: vwvm.rain ? 0.8 : 1,
              child: Container(
                  width: 420,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://media.discordapp.net/attachments/177137813832204288/792412196004823090/heavy_rain-1_jpg-1.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(1)),
                  child: Center(
                    child: Text("Rain",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(
                                0, 0, 0, vwvm.rain ? 0.8 : 0.0))),
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.snow = !vwvm.snow;
            },
            child: Opacity(
              opacity: vwvm.snow ? 0.8 : 1,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.grey,
                    vwvm.snow ? BlendMode.dst : BlendMode.saturation),
                child: Container(
                    width: 420,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        backgroundBlendMode: BlendMode.saturation,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://media.discordapp.net/attachments/177137813832204288/792416111164784670/111798556-565x376_1.png?width=833&height=468"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(1)),
                    child: Center(
                      child: Text("Snow",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(
                                  0, 0, 0, vwvm.snow ? 0.8 : 0.0))),
                    )),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.wind = !vwvm.wind;
            },
            child: Opacity(
              opacity: vwvm.wind ? 0.8 : 1,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.grey,
                    vwvm.wind ? BlendMode.dst : BlendMode.saturation),
                child: Container(
                    width: 420,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://media.discordapp.net/attachments/177137813832204288/792416957915332658/0_GettyImages-106956515.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(1)),
                    child: Center(
                      child: Text("Strong Wind",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(
                                  0, 0, 0, vwvm.wind ? 0.8 : 0.0))),
                    )),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.sun = !vwvm.sun;
            },
            child: Opacity(
              opacity: vwvm.sun ? 0.8 : 1,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.grey,
                    vwvm.sun ? BlendMode.dst : BlendMode.saturation),
                child: Container(
                    width: 420,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://media.discordapp.net/attachments/177137813832204288/792429473365622814/34710388f6426716ba51aac7c7171a72.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(1)),
                    child: Center(
                      child: Text("Strong Sun",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(
                                  0, 0, 0, vwvm.sun ? 0.8 : 0.0))),
                    )),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              vwvm.saveCloth(favw.auth);
              Navigator.pop(context);
            },
            child: Container(
                width: 420,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: primaryColor,
                    border: Border(
                        top: BorderSide(color: borderColor, width: borderWidth),
                        bottom: BorderSide(
                            color: borderColor, width: borderWidth))),
                child: Center(
                  child: Text("Save Cloth",
                      style: TextStyle(fontSize: 15, color: buttonTextColor)),
                )),
          )
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }

  String temperature(double rating) {
    String text;
    if (rating < 10) {
      text = bestWeathersTemperatureForCloth.values[rating.toInt()]
              .toString()
              .substring(32) +
          " (";
    }
    if (rating == 0) {
      text += " -20° — ";
    } else if (rating < 10) {
      text += " " +
          bestWeathersTemperatureForCloth
              .values[(rating - 1).toInt()].clothTemperature
              .toString() +
          "°C — ";
    }
    if (rating < 10) {
      text += bestWeathersTemperatureForCloth
              .values[rating.toInt()].clothTemperature
              .toString() +
          "°C)";
    } else {
      text = "None";
    }
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  String conditions(double rating) {
    String text = additionalWeatherConditions.values[rating.toInt()]
        .toString()
        .substring(28);
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}
// 💨 🧊
