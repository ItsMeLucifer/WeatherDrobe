import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

import 'cloth_creator_page_view.dart';
import 'clothes_list.dart';

class VirtualWardrobeMainView extends ConsumerWidget {
  void _navigateToClothCreator(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClothCreatorPV()));
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tools = watch(toolsVM);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _navigateToClothCreator(context),
              child: Card(
                  child: Container(
                    width: 390,
                    height: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(children: [
                            Center(
                              child: Text("+ ",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: tools.textColor,
                                      fontFamily: tools.fontFamily),
                                  textAlign: TextAlign.center),
                            ),
                            Center(
                              child: Text(
                                "New Clothing",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: tools.textColor,
                                    fontFamily: tools.fontFamily),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ])
                        ]),
                  ),
                  color: tools.primaryColor),
            ),
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
