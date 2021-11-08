import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/pages/AuthenticationPage.dart';
import 'package:weatherdrobe/viewmodels/Firebase/firebase_auth_View_Model.dart';
import 'package:weatherdrobe/widgets/bottomNavigationBar.dart';

class Wrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favm = watch(firebaseAuth);
    favm.addListenerToFirebaseAuth();
    switch (favm.status) {
      case Status.Authenticated:
        return BottomNaviBar();
        break;
      case Status.Unauthenticated:
        return AuthenticationPage();
        break;
      default:
        return AuthenticationPage();
    }
  }
}
