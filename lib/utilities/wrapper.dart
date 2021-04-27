import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/pages/AuthenticationPage.dart';
import 'package:weatherdrobe/viewmodels/firebase/firebase_auth_View_Model.dart';
import 'package:weatherdrobe/widgets/bottomNavigationBar.dart';

class Wrapper extends ConsumerWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    tools.screenWidth = MediaQuery.of(context).size.width;
    tools.screenHeight = MediaQuery.of(context).size.height;
    switch (favm.status) {
      case Status.Authenticated:
        return BottomNaviBar();
        break;
      case Status.Unauthenticated:
        return AuthenticationPage();
        break;
    }
  }
}
