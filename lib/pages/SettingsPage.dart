import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/main.dart';

class Settings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favm = watch(firebaseAuth);
    final tools = watch(toolsVM);
    final vwvm = watch(virtualWardrobe);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              favm.signOut();
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  color: tools.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text(
                'Sign-out',
                style: TextStyle(
                    color: tools.textColor, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}
