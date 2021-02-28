import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favm = watch(firebaseAuth);
    const Color primaryColor = Color.fromRGBO(220, 220, 220, 1);
    const Color secondaryColor = Color.fromRGBO(240, 240, 240, 1);
    const String fontFamily = 'Nexa';
    const double fontSize = 40;
    if (vwvm.userCollections != null && vwvm.userCollections.exists) {
      return Column(
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
                        width: 90,
                        child: Center(
                            child: Text(
                          '👒',
                          style: TextStyle(
                              fontFamily: fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 0
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 1;
                  },
                  child: Card(
                      child: Container(
                          height: 50,
                          width: 90,
                          child: Center(
                              child: Text(
                            '👕',
                            style: TextStyle(
                                fontFamily: fontFamily, fontSize: fontSize),
                            textAlign: TextAlign.center,
                          ))),
                      color: vwvm.actualClothType == 1
                          ? primaryColor
                          : secondaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 2;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: 90,
                        child: Center(
                            child: Text(
                          '👖',
                          style: TextStyle(
                              fontFamily: fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 2
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.actualClothType = 3;
                  },
                  child: Card(
                    child: Container(
                        height: 50,
                        width: 90,
                        child: Center(
                            child: Text(
                          '👟',
                          style: TextStyle(
                              fontFamily: fontFamily, fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ))),
                    color: vwvm.actualClothType == 3
                        ? primaryColor
                        : secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          //Interim solution for test purposes, code will be rewritten for optimization
          vwvm.actualClothType == 0
              ? headwear(vwvm)
              : vwvm.actualClothType == 1
                  ? top(vwvm)
                  : vwvm.actualClothType == 2
                      ? legs(vwvm)
                      : vwvm.actualClothType == 3
                          ? feet(vwvm)
                          : Container()
        ],
      );
    } else {
      vwvm.getGarments(favm.auth);
      return CircularProgressIndicator();
    }
  }
}

Widget headwear(var vwvm) {
  const String fontFamily = 'Nexa';
  var array = vwvm.headwear;
  if (array != null) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                                height: 300,
                                width: 250,
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Color(int.parse(array[index]['color'])),
                                      BlendMode.modulate),
                                  child: Image.asset(
                                      'images/templates/head/${array[index]["dir"]}.png'),
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
                            padding: const EdgeInsets.only(left: 8.0, top: 160),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      //EDIT FIREBASE CLOTHING
                                    },
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )),
                                FlatButton(
                                    onPressed: () {
                                      //DELETE CLOTHING FROM FIREBASE
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
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
                        'images/templates/head/${array[index]["dir"]}.png'),
                  ),
                  color: Colors.white),
            ),
          );
        });
  } else {
    return Container();
  }
}

Widget top(var vwvm) {
  if (vwvm.top != null) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: vwvm.top.length,
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
                        children: [
                          Container(
                              height: 300,
                              width: 250,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Color(int.parse(vwvm.top[index]['color'])),
                                    BlendMode.modulate),
                                child: Image.asset(
                                    'images/templates/top/${vwvm.top[index]["dir"]}.png'),
                              ),
                              color: Colors.white),
                          Text(
                              'Temperature: ${vwvm.temperature(vwvm.top[index]["temperature"])}'),
                          Text(
                              'Good for following extreme weather conditions: ${vwvm.top[index]["sun"] == true ? "Sun" : ""} ${vwvm.top[index]["wind"] == true ? "Wind" : ""} ${vwvm.top[index]["rain"] == true ? "Rain" : ""} ${vwvm.top[index]["snow"] == true ? "Snow" : ""}')
                        ],
                      ),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK')),
                      ],
                    );
                  });
            },
            child: Card(
              child: Container(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Color(int.parse(vwvm.top[index]['color'])),
                        BlendMode.modulate),
                    child: Image.asset(
                        'images/templates/top/${vwvm.top[index]["dir"]}.png'),
                  ),
                  color: Colors.white),
            ),
          );
        });
  } else {
    return Container();
  }
}

Widget legs(var vwvm) {
  if (vwvm.legs != null) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: vwvm.legs.length,
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
                        children: [
                          Container(
                              height: 300,
                              width: 250,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Color(int.parse(vwvm.legs[index]['color'])),
                                    BlendMode.modulate),
                                child: Image.asset(
                                    'images/templates/legs/${vwvm.legs[index]["dir"]}.png'),
                              ),
                              color: Colors.white),
                          Text(
                              'Temperature: ${vwvm.temperature(vwvm.legs[index]["temperature"])}'),
                          Text(
                              'Good for following extreme weather conditions: ${vwvm.legs[index]["sun"] == true ? "Sun" : ""} ${vwvm.legs[index]["wind"] == true ? "Wind" : ""} ${vwvm.legs[index]["rain"] == true ? "Rain" : ""} ${vwvm.legs[index]["snow"] == true ? "Snow" : ""}')
                        ],
                      ),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK')),
                      ],
                    );
                  });
            },
            child: Card(
              child: Container(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Color(int.parse(vwvm.legs[index]['color'])),
                        BlendMode.modulate),
                    child: Image.asset(
                        'images/templates/legs/${vwvm.legs[index]["dir"]}.png'),
                  ),
                  color: Colors.white),
            ),
          );
        });
  } else {
    return Container();
  }
}

Widget feet(var vwvm) {
  if (vwvm.feet != null) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: vwvm.feet.length,
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
                        children: [
                          Container(
                              height: 300,
                              width: 250,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Color(int.parse(vwvm.feet[index]['color'])),
                                    BlendMode.modulate),
                                child: Image.asset(
                                    'images/templates/feet/${vwvm.feet[index]["dir"]}.png'),
                              ),
                              color: Colors.white),
                          Text(
                              'Temperature: ${vwvm.temperature(vwvm.feet[index]["temperature"])}'),
                          Text(
                              'Good for following extreme weather conditions: ${vwvm.feet[index]["sun"] == true ? "Sun" : ""} ${vwvm.feet[index]["wind"] == true ? "Wind" : ""} ${vwvm.feet[index]["rain"] == true ? "Rain" : ""} ${vwvm.feet[index]["snow"] == true ? "Snow" : ""}')
                        ],
                      ),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK')),
                      ],
                    );
                  });
            },
            child: Card(
              child: Container(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Color(int.parse(vwvm.feet[index]['color'])),
                        BlendMode.modulate),
                    child: Image.asset(
                        'images/templates/feet/${vwvm.feet[index]["dir"]}.png'),
                  ),
                  color: Colors.white),
            ),
          );
        });
  } else {
    return Container();
  }
}
