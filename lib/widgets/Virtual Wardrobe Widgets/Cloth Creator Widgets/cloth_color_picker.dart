import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothColorPicker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vwvm = watch(virtualWardrobe);
    final tools = watch(toolsVM);
    return Scaffold(
      body: Column(
        children: [
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
                'Color',
                style: TextStyle(fontSize: 30, fontFamily: tools.fontFamily),
              ),
            )),
          ),
          MaterialPicker(
            pickerColor: vwvm.color,
            onColorChanged: (Color color) {
              vwvm.color = color;
              tools.controller.nextPage(
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
            enableLabel: true,
          ),
        ],
      ),
    );
  }
}
