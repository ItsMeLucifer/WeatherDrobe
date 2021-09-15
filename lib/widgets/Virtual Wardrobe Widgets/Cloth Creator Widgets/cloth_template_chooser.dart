import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothTemplateChooser extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final tools = watch(toolsVM);
    double iconSize = 40;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 5),
          child: Container(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Outfit Creator',
              style: TextStyle(
                  fontSize: 60,
                  fontFamily: tools.fontFamily,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: Container(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Template',
              style: TextStyle(fontSize: 30, fontFamily: tools.fontFamily),
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 9),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        vwvm.type = 0;
                      },
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '👒',
                              style: TextStyle(fontSize: iconSize),
                            ),
                          ),
                          color: vwvm.type == 0
                              ? tools.secondaryColor
                              : tools.tetriaryColor)),
                  GestureDetector(
                      onTap: () {
                        vwvm.type = 4;
                      },
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '👗',
                              style: TextStyle(fontSize: iconSize),
                            ),
                          ),
                          color: vwvm.type == 4
                              ? tools.secondaryColor
                              : tools.tetriaryColor)),
                  GestureDetector(
                      onTap: () {
                        vwvm.type = 1;
                      },
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '👕',
                              style: TextStyle(fontSize: iconSize),
                            ),
                          ),
                          color: vwvm.type == 1
                              ? tools.secondaryColor
                              : tools.tetriaryColor)),
                  GestureDetector(
                      onTap: () {
                        vwvm.type = 2;
                      },
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '👖',
                              style: TextStyle(fontSize: iconSize),
                            ),
                          ),
                          color: vwvm.type == 2
                              ? tools.secondaryColor
                              : tools.tetriaryColor)),
                  GestureDetector(
                      onTap: () {
                        vwvm.type = 3;
                      },
                      child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '👟',
                              style: TextStyle(fontSize: iconSize),
                            ),
                          ),
                          color: vwvm.type == 3
                              ? tools.secondaryColor
                              : tools.tetriaryColor)),
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  itemCount: vwvm.templateNames[vwvm.type].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        vwvm.isTemplateChosen = true;
                        vwvm.dir = vwvm.templateNames[vwvm.type][index];
                      },
                      child: Card(
                        child: Image.asset(
                            'images/templates/${vwvm.clothTypeName}/${vwvm.templateNames[vwvm.type][index]}.png'),
                      ),
                    );
                  })),
        ),
      ]),
    ));
  }
}
