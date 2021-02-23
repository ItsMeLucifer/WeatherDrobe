import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothAdditionalConditions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favm = watch(firebaseAuth);
    Color primaryColor = Color.fromRGBO(72, 67, 73, 0.5);
    Color borderColor = Color.fromRGBO(72, 67, 73, 0.3);
    Color buttonTextColor = Colors.white;
    Color textColor = Colors.black;
    double borderWidth = 3;
    return Scaffold(
      body: Column(children: [
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
              'Conditions',
              style: TextStyle(fontSize: 30, fontFamily: 'Nexa'),
            ),
          )),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 9.0, bottom: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Choose with what weather conditions this cloth is suitable",
                  style: TextStyle(
                      fontSize: 15, color: textColor, fontFamily: 'Nexa'),
                  textAlign: TextAlign.center),
            ),
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
                          color:
                              Color.fromRGBO(0, 0, 0, vwvm.rain ? 0.8 : 0.0))),
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
              colorFilter: ColorFilter.mode(
                  Colors.grey, vwvm.sun ? BlendMode.dst : BlendMode.saturation),
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
                            color:
                                Color.fromRGBO(0, 0, 0, vwvm.sun ? 0.8 : 0.0))),
                  )),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            vwvm.saveCloth(favm.auth);
            vwvm.getGarments(favm.auth);
            Navigator.pop(context);
          },
          child: Container(
              width: 420,
              height: 50,
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                  // color: primaryColor,
                  border: Border(
                      top: BorderSide(color: borderColor, width: borderWidth),
                      bottom:
                          BorderSide(color: borderColor, width: borderWidth))),
              child: Center(
                child: Text("Save Cloth",
                    style: TextStyle(
                        fontSize: 15, color: Colors.black, fontFamily: 'Nexa')),
              )),
        )
      ]),
    );
  }
}
