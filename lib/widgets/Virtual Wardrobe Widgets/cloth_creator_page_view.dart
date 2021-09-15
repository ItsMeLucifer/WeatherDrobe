import 'package:flutter/material.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_additional_conditions.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_color_picker.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_temperature_setter.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_template_chooser.dart';

class ClothCreatorPV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: 0,
    );
    return PageView(
      controller: controller,
      children: [
        ClothTemplateChooser(),
        ClothColorPicker(),
        ClothTemperatureSetter(),
        ClothAdditionalConditions(),
      ],
    );
  }
}
