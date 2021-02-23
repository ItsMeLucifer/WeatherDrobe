// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:weatherdrobe/main.dart';
// import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_template_chooser.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// enum additionalWeatherConditions { snow, rain, hail, wind, none }

// class ClothCreator extends ConsumerWidget {
//   double iconSize = 30;
//   double opacity = 0.3;
//   double conditionsRating = 2;
//   Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);
//   Color primaryColor = Color.fromRGBO(72, 67, 73, 0.5);
//   Color secondaryColor = Color.fromRGBO(0, 121, 140, 1);
//   Color thirdColor = Color.fromRGBO(81, 163, 163, 0.5);
//   Color borderColor = Color.fromRGBO(72, 67, 73, 0.3);
//   Color textColor = Colors.black;
//   double borderWidth = 3;
//   Color buttonTextColor = Colors.white;

//   Widget build(BuildContext context, ScopedReader watch) {
//     final vwvm = watch(virtualWardrobe);
//     final favm = watch(firebaseAuth);
//     void changeColor(Color color) {
//       vwvm.color = color;
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ClothTemplateChooser()),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 35),
//                 child: Container(
//                     width: 420,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: primaryColor,
//                         border: Border(
//                             top: BorderSide(
//                                 color: borderColor, width: borderWidth),
//                             bottom: BorderSide(
//                                 color: borderColor, width: borderWidth))),
//                     child: Center(
//                       child: Text('Template',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: buttonTextColor)),
//                     )),
//               )),
//           GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       titlePadding: const EdgeInsets.all(5.0),
//                       contentPadding: const EdgeInsets.all(5.0),
//                       title: Text(
//                         'Pick a color',
//                         textAlign: TextAlign.center,
//                       ),
//                       content: SingleChildScrollView(
//                         child: MaterialPicker(
//                           pickerColor: vwvm.color,
//                           onColorChanged: (Color color) {
//                             vwvm.color = color;
//                           },
//                           enableLabel: true,
//                         ),
//                       ),
//                       actions: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text('Previously Picked Color:'),
//                             Container(
//                                 width: 25,
//                                 height: 25,
//                                 decoration: BoxDecoration(
//                                     color: vwvm.color,
//                                     borderRadius: BorderRadius.circular(50)))
//                           ],
//                         ),
//                         FlatButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Select')),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Container(
//                     width: 420,
//                     height: 50,
//                     decoration: BoxDecoration(
//                         color: primaryColor,
//                         border: Border(
//                             top: BorderSide(
//                                 color: borderColor, width: borderWidth),
//                             bottom: BorderSide(
//                                 color: borderColor, width: borderWidth))),
//                     child: Center(
//                         child: Text('Color',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: buttonTextColor)))),
//               )),
//           Padding(
//             padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
//             child: Text(
//               "Choose which outside temperature is best for this cloth",
//               style: TextStyle(fontSize: 18, color: textColor),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0, bottom: 7.5),
//             child: Center(
//                 child: Text(vwvm.temperature(vwvm.temperatureRating),
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: textColor,
//                         fontWeight: FontWeight.bold))),
//           ),
//           Slider(
//             value: vwvm.temperatureRating,
//             min: 0,
//             max: 10,
//             divisions: 10,
//             activeColor: secondaryColor,
//             inactiveColor: thirdColor,
//             onChanged: (double value) {
//               vwvm.temperatureRating = value;
//             },
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 15, right: 15, top: 0.0, bottom: 10),
//               child: Text(
//                   "Choose with what weather conditions this cloth is suitable",
//                   style: TextStyle(fontSize: 18, color: textColor),
//                   textAlign: TextAlign.center),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               vwvm.rain = !vwvm.rain;
//             },
//             child: Opacity(
//               opacity: vwvm.rain ? 0.8 : 1,
//               child: Container(
//                   width: 420,
//                   height: 70,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       backgroundBlendMode: BlendMode.saturation,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                             "https://media.discordapp.net/attachments/177137813832204288/792412196004823090/heavy_rain-1_jpg-1.png"),
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.circular(1)),
//                   child: Center(
//                     child: Text("Rain",
//                         style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromRGBO(
//                                 0, 0, 0, vwvm.rain ? 0.8 : 0.0))),
//                   )),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               vwvm.snow = !vwvm.snow;
//             },
//             child: Opacity(
//               opacity: vwvm.snow ? 0.8 : 1,
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey,
//                     vwvm.snow ? BlendMode.dst : BlendMode.saturation),
//                 child: Container(
//                     width: 420,
//                     height: 70,
//                     decoration: BoxDecoration(
//                         color: Colors.grey,
//                         backgroundBlendMode: BlendMode.saturation,
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               "https://media.discordapp.net/attachments/177137813832204288/792416111164784670/111798556-565x376_1.png?width=833&height=468"),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(1)),
//                     child: Center(
//                       child: Text("Snow",
//                           style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromRGBO(
//                                   0, 0, 0, vwvm.snow ? 0.8 : 0.0))),
//                     )),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               vwvm.wind = !vwvm.wind;
//             },
//             child: Opacity(
//               opacity: vwvm.wind ? 0.8 : 1,
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey,
//                     vwvm.wind ? BlendMode.dst : BlendMode.saturation),
//                 child: Container(
//                     width: 420,
//                     height: 70,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               "https://media.discordapp.net/attachments/177137813832204288/792416957915332658/0_GettyImages-106956515.png"),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(1)),
//                     child: Center(
//                       child: Text("Strong Wind",
//                           style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromRGBO(
//                                   0, 0, 0, vwvm.wind ? 0.8 : 0.0))),
//                     )),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               vwvm.sun = !vwvm.sun;
//             },
//             child: Opacity(
//               opacity: vwvm.sun ? 0.8 : 1,
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey,
//                     vwvm.sun ? BlendMode.dst : BlendMode.saturation),
//                 child: Container(
//                     width: 420,
//                     height: 70,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               "https://media.discordapp.net/attachments/177137813832204288/792429473365622814/34710388f6426716ba51aac7c7171a72.png"),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(1)),
//                     child: Center(
//                       child: Text("Strong Sun",
//                           style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromRGBO(
//                                   0, 0, 0, vwvm.sun ? 0.8 : 0.0))),
//                     )),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               vwvm.saveCloth(favm.auth);
//               vwvm.getGarments(favm.auth);
//               Navigator.pop(context);
//             },
//             child: Container(
//                 width: 420,
//                 height: 50,
//                 margin: const EdgeInsets.only(top: 10),
//                 decoration: BoxDecoration(
//                     color: primaryColor,
//                     border: Border(
//                         top: BorderSide(color: borderColor, width: borderWidth),
//                         bottom: BorderSide(
//                             color: borderColor, width: borderWidth))),
//                 child: Center(
//                   child: Text("Save Cloth",
//                       style: TextStyle(fontSize: 15, color: buttonTextColor)),
//                 )),
//           )
//         ],
//       ),
//       backgroundColor: backgroundColor,
//     );
//   }

//   String conditions(double rating) {
//     String text = additionalWeatherConditions.values[rating.toInt()]
//         .toString()
//         .substring(28);
//     return "${text[0].toUpperCase()}${text.substring(1)}";
//   }
// }
// // 💨 🧊
