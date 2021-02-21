import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class Settings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favm = watch(firebaseAuth);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            favm.signOut();
          },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Center(child: Text('Sign-out')),
          ),
        )
      ],
    );
  }
}
