import 'package:flutter/material.dart';

//Unnecessary for now, but may be used in the future
class Cloth {
  final int type;
  final Color color;
  final String clothDir;
  final int temperature;
  final bool sun;
  final bool wind;
  final bool rain;
  final bool snow;

  Cloth(this.type, this.color, this.clothDir, this.temperature, this.sun,
      this.snow, this.rain, this.wind);
}
