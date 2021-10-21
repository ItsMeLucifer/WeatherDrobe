import 'package:flutter/material.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_additional_conditions.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_color_picker.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_temperature_setter.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_template_chooser.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:weatherdrobe/main.dart';

class ClothCreatorPV extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final tools = watch(toolsVM);
    return PageView(
      controller: tools.controller,
      children: [
        ClothTemplateChooser(),
        ClothColorPicker(),
        ClothTemperatureSetter(),
        ClothAdditionalConditions(),
      ],
    );
  }
}
