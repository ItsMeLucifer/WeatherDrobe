import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ClothType { head, top, legs, feet }

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

  Future<void> saveCloth(FirebaseAuth auth) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    ClothType clothType = ClothType.values.elementAt(type);
    //users.add({'userID': userID});
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
      'color': color.toString()
    });
  }
}
