import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ClothesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    const double fontSize = 40;
    const double talesWidth = 65;
    if (vwvm.userCollections != null && vwvm.userCollections.exists) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 0;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: talesWidth,
                        child: Center(
                            child: Text(
                          '👒',
                          style: TextStyle(
                              fontFamily: tools.fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 0
                        ? tools.secondaryColor
                        : tools.tetriaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 4;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: talesWidth,
                        child: Center(
                            child: Text(
                          '👗',
                          style: TextStyle(
                              fontFamily: tools.fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 4
                        ? tools.secondaryColor
                        : tools.tetriaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 1;
                  },
                  child: Card(
                      child: Container(
                          height: 50,
                          width: talesWidth,
                          child: Center(
                              child: Text(
                            '👕',
                            style: TextStyle(
                                fontFamily: tools.fontFamily,
                                fontSize: fontSize),
                            textAlign: TextAlign.center,
                          ))),
                      color: vwvm.actualClothType == 1
                          ? tools.secondaryColor
                          : tools.tetriaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 2;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: talesWidth,
                        child: Center(
                            child: Text(
                          '👖',
                          style: TextStyle(
                              fontFamily: tools.fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 2
                        ? tools.secondaryColor
                        : tools.tetriaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 3;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: talesWidth,
                        child: Center(
                            child: Text(
                          '👟',
                          style: TextStyle(
                              fontFamily: tools.fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 3
                        ? tools.secondaryColor
                        : tools.tetriaryColor,
                  ),
                ),
              ],
            ),
          ),
          clothes(vwvm.getCurrentGarmentsList(), watch, context)
        ],
      );
    } else {
      vwvm.getGarments(favm.auth);
      return CircularProgressIndicator();
    }
  }
}

Widget clothes(List<QueryDocumentSnapshot> array, ScopedReader watch,
    BuildContext context) {
  const String fontFamily = 'Nexa';
  final vwvm = watch(virtualWardrobe);
  final favm = watch(firebaseAuth);
  // final cc = watch(clothingChooser);
  // final tools = watch(toolsVM);
  // final hfvm = watch(hourlyData);

  if (array != null || array.length != 0) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: array.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                                height: 300,
                                width: 251,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Color(int.parse(array[index]['color'])),
                                      BlendMode.modulate),
                                  child: Image.asset(
                                      'images/templates/${vwvm.getClothTypeName}/${array[index]["dir"]}.png'),
                                ),
                                color: Colors.white),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Temperature: ',
                                style: TextStyle(fontFamily: fontFamily),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                '${vwvm.temperature(array[index]["temperature"])}',
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              array[index]["sun"] == true ||
                                      array[index]["wind"] == true ||
                                      array[index]["rain"] == true ||
                                      array[index]["snow"] == true
                                  ? Text(
                                      'Good for following weather conditions: ',
                                      style: TextStyle(
                                        fontFamily: fontFamily,
                                      ),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["sun"] == true
                                  ? Text('• Sun',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["wind"] == true
                                  ? Text('• Wind',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["rain"] == true
                                  ? Text('• Rain',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["snow"] == true
                                  ? Text('• Snow',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center)
                                  : Container(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      vwvm.deleteGarment(
                                          array[index].id, favm.auth);
                                      vwvm.getGarments(favm.auth);
                                      vwvm.userCollections = null;
                                      // cc.proposals = [];
                                      // cc.chooseClothing(
                                      //     vwvm.headwear,
                                      //     vwvm.tops,
                                      //     vwvm.bottoms,
                                      //     vwvm.footwear,
                                      //     vwvm.costumes,
                                      //     10,
                                      //     tools
                                      //         .calculateTheMedian(
                                      //             hfvm.weatherIds)
                                      //         .toInt(),
                                      //     false);

                                      // Czasowe rozwiązanie, trzeba sprawić aby character model się update'ował po kliknięciu tego przycisku
                                      //Phoenix.rebirth(context);

                                      //DELETE CLOTHING FROM FIREBASE
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Card(
              child: Container(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Color(int.parse(array[index]['color'])),
                        BlendMode.modulate),
                    child: Image.asset(
                        'images/templates/${vwvm.getClothTypeName}/${array[index]["dir"]}.png'),
                  ),
                  color: Colors.white),
            ),
          );
        });
  } else {
    return Container();
  }
}
