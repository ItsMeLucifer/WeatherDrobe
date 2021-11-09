import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ClothType { headwear, tops, bottoms, footwear, costumes }
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
    if (auth.currentUser == null) return;
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

  List<QueryDocumentSnapshot> getCurrentGarmentsList() {
    if (actualClothType == 0) return headwear;
    if (actualClothType == 1) return tops;
    if (actualClothType == 2) return bottoms;
    if (actualClothType == 3) return footwear;
    return costumes;
  }

  List<QueryDocumentSnapshot> _headwear = [];
  List<QueryDocumentSnapshot> get headwear => _headwear;
  set headwear(List<QueryDocumentSnapshot> value) {
    _headwear = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _tops = [];
  List<QueryDocumentSnapshot> get tops => _tops;
  set tops(List<QueryDocumentSnapshot> value) {
    _tops = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _bottoms = [];
  List<QueryDocumentSnapshot> get bottoms => _bottoms;
  set bottoms(List<QueryDocumentSnapshot> value) {
    _bottoms = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _footwear = [];
  List<QueryDocumentSnapshot> get footwear => _footwear;
  set footwear(List<QueryDocumentSnapshot> value) {
    _footwear = value;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> _costumes = [];
  List<QueryDocumentSnapshot> get costumes => _costumes;
  set costumes(List<QueryDocumentSnapshot> value) {
    _costumes = value;
    notifyListeners();
  }

  DocumentSnapshot userCollections;
  void getGarments(FirebaseAuth auth) async {
    List<QueryDocumentSnapshot> temp = [];
    if (auth.currentUser == null) return;
    await users
        .doc(auth.currentUser.uid)
        .collection('headwear')
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
        .collection('tops')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    tops = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('bottoms')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    bottoms = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('costumes')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    costumes = temp;
    temp = [];
    await users
        .doc(auth.currentUser.uid)
        .collection('footwear')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              if (querySnapshot.size > 0)
                {
                  querySnapshot.docs.forEach((doc) {
                    temp.add(doc);
                  })
                }
            });
    footwear = temp;
    temp = [];
    userCollections = await users.doc(auth.currentUser.uid).get();
    notifyListeners();
  }

  void deleteGarment(String documentId, FirebaseAuth auth) async {
    print("DocumentID: " + documentId);
    if (auth.currentUser == null) return;
    await users
        .doc(auth.currentUser.uid)
        .collection(getClothTypeName)
        .doc(documentId)
        .delete();
  }

  final templateNames = [
    ['hat', 'knit-hat-with-pom-pom', 'men-hat', 'winter-hat'],
    [
      'tank-top',
      'chiffon-suffle-blouse',
      'collarless-cotton-shirt',
      'cotton-cardigan',
      'denim-jacket',
      'cotton-polo-shirt',
      'denim-shirt',
      'formal-shirt',
      'henley-shirt',
      'hooded-jacket',
      'jersey-blazer',
      'leather-biker-jacket',
      'long-sleeves-t-shirt',
      'nylon-jacket',
      'oxford-wave-blazer',
      'padded-vest',
      'sweater',
      't-shirt-with-design',
      'tank-top',
      'trench-coat',
      'v-neck-shirt'
    ],
    [
      'jeans',
      'boyfriend-low-jean',
      'chino-shorts',
      'chinos-pants',
      'circle-skirt',
      'denim-shorts',
      'flare-pants',
      'harem-pants',
      'leggins',
      'oxford-wave-suit-pants',
      'pants',
      'pegged-pants',
      'peplum-skirt-1',
      'peplum-skirt',
      'slim-fit-pants',
      'slit-skirt',
      'sweatpants',
      'tulle-skirt'
    ],
    [
      'flip-flops',
      'ankle-boots',
      'ballets-flats',
      'flat-shoes',
      'gladiator-sandal',
      'high-heel',
      'high-heels',
      'leather-chelsea-boots',
      'leather-derby-shoe',
      'leather-shoes',
      'loafer',
      'platform-sandals',
      //'rain-boots',
      'sleepers',
      'sneaker',
      'sneakers',
      'wool-boots'
    ],
    [
      'jumpsuit',
      'chiffon-dress',
      'cocktail-dress',
      'draped-top',
      'drees',
      'dress-with-butterfly-sleeves',
      'dress',
      'jersey-wrap-dress',
      'long-bandeau-dress',
      'long-sleeveless-dress',
      'lyocell-shirt-dress',
      'off-the-shoulder-dress',
      'one-shoulder-dress',
      'peplum-top'
    ]
  ];
}
