import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class Settings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    final hfvm = watch(hourlyData);
    return SafeArea(
      child: Card(
        color: tools.primaryColor,
        child: Container(
          height: 600,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("How many hours in Hourly Forecast: ",
                        style: TextStyle(
                            fontFamily: tools.fontFamily,
                            color: tools.textColor)),
                    DropdownButton<String>(
                      value: hfvm.numberOfHoursAnalysed.toString(),
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: tools.textColor),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          fontFamily: tools.fontFamily, color: tools.textColor),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue) {
                        hfvm.numberOfHoursAnalysed = int.parse(newValue);
                        hfvm.getFirstHourWithHighPropabilityOfPrecipitation();
                      },
                      dropdownColor: tools.primaryColor,
                      items: <String>[
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10',
                        '11',
                        '12',
                        '13',
                        '14',
                        '15'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontFamily: tools.fontFamily,
                                  color: tools.textColor),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    tools.indicator =
                        false; // STOP PROGRESS INDICATOR IN AUTH PAGE
                    favm.signOut();
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: tools.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: Text(
                      'Sign-out',
                      style: TextStyle(
                          color: tools.textColor, fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
