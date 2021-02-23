import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final favm = watch(firebaseAuth);
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
                            'Head',
                            textAlign: TextAlign.center,
                          )))),
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
                            'Top',
                            textAlign: TextAlign.center,
                          )))),
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
                            'Legs',
                            textAlign: TextAlign.center,
                          )))),
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
                            'Feet',
                            textAlign: TextAlign.center,
                          )))),
                ),
              ],
            ),
          ),
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
  if (vwvm.headwear != null) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(10),
        itemCount: vwvm.headwear.length,
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
                                    Color(int.parse(
                                        vwvm.headwear[index]['color'])),
                                    BlendMode.modulate),
                                child: Image.asset(
                                    'images/templates/head/${vwvm.headwear[index]["dir"]}.png'),
                              ),
                              color: Colors.white),
                          Text(
                              'Temperature: ${vwvm.temperature(vwvm.headwear[index]["temperature"])}'),
                          Text(
                              'Good for following extreme weather conditions: ${vwvm.headwear[index]["sun"] == true ? "Sun" : ""} ${vwvm.headwear[index]["wind"] == true ? "Wind" : ""} ${vwvm.headwear[index]["rain"] == true ? "Rain" : ""} ${vwvm.headwear[index]["snow"] == true ? "Snow" : ""}')
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
                        Color(int.parse(vwvm.headwear[index]['color'])),
                        BlendMode.modulate),
                    child: Image.asset(
                        'images/templates/head/${vwvm.headwear[index]["dir"]}.png'),
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
