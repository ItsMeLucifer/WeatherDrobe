import 'package:cloud_firestore/cloud_firestore.dart';

class Clothing {
  final QueryDocumentSnapshot headwear;
  final QueryDocumentSnapshot top;
  final QueryDocumentSnapshot bottom;
  final QueryDocumentSnapshot footwear;
  final isCostume;

  Clothing(this.headwear, this.top, this.bottom, this.footwear, this.isCostume);
}
