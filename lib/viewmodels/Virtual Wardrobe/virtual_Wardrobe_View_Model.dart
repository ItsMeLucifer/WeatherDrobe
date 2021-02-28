import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weatherdrobe/models/cloth.dart';

enum ClothType { head, top, legs, feet }
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

class VirtualWardrobeViewModel extends ChangeNotifier {
  bool _snow = false;
  bool get snow => _snow;
  set snow(bool value) {
    _snow = value;
    notifyListeners();
  }

  bool _rain = false;
  bool get rain => _rain;
  set rain(bool value) {
    _rain = value;
    notifyListeners();
  }

  bool _sun = false;
  bool get sun => _sun;
  set sun(bool value) {
    _sun = value;
    notifyListeners();
  }

  bool _wind = false;
  bool get wind => _wind;
  set wind(bool value) {
    _wind = value;
    notifyListeners();
  }

  double _temperatureRating = 10;
  double get temperatureRating => _temperatureRating;
  set temperatureRating(double value) {
    _temperatureRating = value;
    notifyListeners();
  }

  int _type = 0;
  int get type => _type;
  set type(int value) {
    _type = value;
    notifyListeners();
  }

  String _dir = '';
  String get dir => _dir;
  set dir(String value) {
    _dir = value;
    notifyListeners();
  }

  bool _isTemplateChosen = false;
  bool get isTemplateChosen => _isTemplateChosen;
  set isTemplateChosen(bool value) {
    _isTemplateChosen = value;
    notifyListeners();
  }

  String get clothTypeName => ClothType.values
      .elementAt(type)
      .toString()
      .substring(10, ClothType.values.elementAt(type).toString().length);

  bool _showColorDialogBox = false;
  bool get showColorDialogBox => _showColorDialogBox;
  set showColorDialogBox(bool value) {
    _showColorDialogBox = value;
    notifyListeners();
  }

  Color _color = Colors.white;
  Color get color => _color;
  set color(Color value) {
    _color = value;
    notifyListeners();
  }

  String get getClothTypeName =>
      ClothType.values.elementAt(actualClothType).toString().substring(
          10, ClothType.values.elementAt(actualClothType).toString().length);

  String temperature(double rating) {
    String text;
    if (rating < 10) {
      text = bestWeathersTemperatureForCloth.values[rating.toInt()]
              .toString()
              .substring(32) +
          " (";
    }
    if (rating == 0) {
      text += "-20° — ";
    } else if (rating < 10) {
      text += bestWeathersTemperatureForCloth
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

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void saveCloth(FirebaseAuth auth) {
    users
        .doc(auth.currentUser.uid)
        .set({'email': auth.currentUser.email, 'userID': auth.currentUser.uid});
    users.doc(auth.currentUser.uid).collection(clothTypeName).add({
      'temperature': temperatureRating,
      'snow': snow,
      'rain': rain,
      'sun': sun,
      'wind': wind,
      'dir': dir,
      'color': color.toString().substring(6, color.toString().length - 1)
    });
  }

  int _actualClothType = 0;
  int get actualClothType => _actualClothType;
  set actualClothType(int value) {
    _actualClothType = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _headwear = [];
  List<QueryDocumentSnapshot> get headwear => _headwear;
  set headwear(List<QueryDocumentSnapshot> value) {
    _headwear = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _top = [];
  List<QueryDocumentSnapshot> get top => _top;
  set top(List<QueryDocumentSnapshot> value) {
    _top = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _legs = [];
  List<QueryDocumentSnapshot> get legs => _legs;
  set legs(List<QueryDocumentSnapshot> value) {
    _legs = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _feet = [];
  List<QueryDocumentSnapshot> get feet => _feet;
  set feet(List<QueryDocumentSnapshot> value) {
    _feet = value;
    notifyListeners();
  }

  DocumentSnapshot userCollections;
  void getGarments(FirebaseAuth auth) async {
    List<QueryDocumentSnapshot> temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('head')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    headwear = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('top')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    top = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('legs')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    legs = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('feet')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    feet = temp;
    temp = [];
    userCollections = await users.doc(auth.currentUser.uid).get();
    notifyListeners();
  }
}
