import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weatherdrobe/widgets/Virtual Wardrobe Widgets/cloth_type_select_buttons.dart';

class ClothesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    if (vwvm.userCollections != null && vwvm.userCollections.exists) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClothTypeSelectButtons(),
          Divider(
            height: 20,
            thickness: 1,
            indent: 30,
            endIndent: 30,
            color: tools.textColor,
          ),
          clothes(vwvm.getCurrentGarmentsList(), watch, context)
        ],
      );
    } else {
      vwvm.getGarments(favm.auth);
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 50, top: 50.0, left: 175, right: 175),
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(tools.textColor)),
      );
    }
  }
}

Widget clothes(List<QueryDocumentSnapshot> array, ScopedReader watch,
    BuildContext context) {
  final vwvm = watch(virtualWardrobe);
  final favm = watch(firebaseAuth);
  final cc = watch(clothingChooser);
  final tools = watch(toolsVM);

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
                                color: Color.fromRGBO(0, 0, 0, 0)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Temperature: ',
                                style: TextStyle(
                                    fontFamily: tools.fontFamily,
                                    color: tools.textColor),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                '${vwvm.temperature(array[index]["temperature"])}',
                                style: TextStyle(
                                    fontFamily: tools.fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: tools.textColor),
                                textAlign: TextAlign.start,
                              ),
                              array[index]["sun"] == true ||
                                      array[index]["wind"] == true ||
                                      array[index]["rain"] == true ||
                                      array[index]["snow"] == true
                                  ? Text(
                                      'Good for following weather conditions: ',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          color: tools.textColor),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["sun"] == true
                                  ? Text('• Sun',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["wind"] == true
                                  ? Text('• Wind',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["rain"] == true
                                  ? Text('• Rain',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
                                      textAlign: TextAlign.start)
                                  : Container(),
                              array[index]["snow"] == true
                                  ? Text('• Snow',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
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
                                      cc.restartAlgorithm();
                                      //DELETE CLOTHING FROM FIREBASE
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
                                    )),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                          fontFamily: tools.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: tools.textColor),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      backgroundColor: tools.quaternaryColor,
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
                    color: Color.fromRGBO(0, 0, 0, 0)),
                color: Color.fromRGBO(0, 0, 0, 0)),
          );
        });
  } else {
    return Container();
  }
}
