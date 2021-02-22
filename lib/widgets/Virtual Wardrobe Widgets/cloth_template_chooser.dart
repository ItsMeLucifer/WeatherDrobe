import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothTemplateChooser extends ConsumerWidget {
  int clothTemplatesAmount = 4;
  var templateNames = [
    ['blank_fedora'],
    ['blank_shirt'],
    ['blank_pants'],
    ['blank_shoes']
  ];
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    return Scaffold(
        // body: ListView.builder(
        //     padding: const EdgeInsets.all(8),
        //     itemCount: clothTemplatesAmount,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Card(
        //           child: ListTile(
        //               leading: Image.asset(
        //                   'images/templates/${templateNames[index]}.png')));
        //     }),
        body: Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    vwvm.type = 0;
                  },
                  child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue[300]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200]),
                      child: Center(
                        child: Text(
                          'Head',
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.type = 1;
                  },
                  child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue[300]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200]),
                      child: Center(
                        child: Text(
                          'Top',
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.type = 2;
                  },
                  child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue[300]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200]),
                      child: Center(
                        child: Text(
                          'Bottom',
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    vwvm.type = 3;
                  },
                  child: Container(
                      width: 90,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue[300]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200]),
                      child: Center(
                        child: Text(
                          'Shoes',
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 90),
        child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 3,
            children: List.generate(templateNames[vwvm.type].length, (index) {
              return GestureDetector(
                onTap: () {
                  vwvm.isTemplateChosen = true;
                  vwvm.dir = templateNames[vwvm.type][index];
                },
                child: Card(
                  child: Image.asset(
                      'images/templates/${vwvm.clothTypeName}/${templateNames[vwvm.type][index]}.png'),
                ),
              );
            })),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Card(
              child: Container(
                  width: 420,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.blue[300])),
                  child: Center(
                      child: Text(
                    'Save!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
              color: Colors.blue[100]),
        ),
      )
    ]));
  }
}
