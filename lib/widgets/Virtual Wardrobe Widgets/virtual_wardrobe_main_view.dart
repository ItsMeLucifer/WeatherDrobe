import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';
import 'clothes_list.dart';

class VirtualWardrobeMainView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tools = watch(toolsVM);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Card(
              color: tools.quaternaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                        child: Text(
                      'Your Virtual Wardrobe:',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: tools.fontFamily,
                          fontWeight: FontWeight.w500,
                          color: tools.textColor),
                    )),
                  ),
                  ClothesList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
