import 'package:flutter/material.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_additional_conditions.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_color_picker.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_temperature_setter.dart';
import 'package:weatherdrobe/widgets/Virtual%20Wardrobe%20Widgets/Cloth%20Creator%20Widgets/cloth_template_chooser.dart';
import 'package:page_indicator/page_indicator.dart';

class ClothCreatorPV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(
      initialPage: 0,
    );
    return PageIndicatorContainer(
      child: PageView(
        controller: controller,
        children: [
          ClothTemplateChooser(),
          ClothColorPicker(),
          ClothTemperatureSetter(),
          ClothAdditionalConditions(),
        ],
      ),
      align: IndicatorAlign.bottom,
      length: 4,
      indicatorSpace: 5.0,
      padding: const EdgeInsets.all(10),
      indicatorColor: Colors.black12,
      indicatorSelectorColor: Colors.black,
      shape: IndicatorShape.roundRectangleShape(
          size: Size.square(12), cornerSize: Size.square(3)),
    );
  }
}
