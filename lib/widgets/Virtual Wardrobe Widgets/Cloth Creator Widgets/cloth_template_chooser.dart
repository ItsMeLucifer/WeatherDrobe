import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/widgets/Virtual Wardrobe Widgets/cloth_type_select_buttons.dart';

class ClothTemplateChooser extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final tools = watch(toolsVM);
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
        ClothTypeSelectButtons(),
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
                        tools.controller.nextPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn);
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
