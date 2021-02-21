import 'package:flutter/material.dart';

enum clothType { head, top, legs, feet }
enum bestWeathersTemperatureForCloth {
  freezing,
  cold,
  chilly,
  brisk,
  cool,
  mild,
  perfect,
  warm,
  hot,
  scorching,
}

extension clothTemperatureExtension on bestWeathersTemperatureForCloth {
  static const clothTemperatures = {
    bestWeathersTemperatureForCloth.freezing: -10,
    bestWeathersTemperatureForCloth.cold: 0,
    bestWeathersTemperatureForCloth.chilly: 4,
    bestWeathersTemperatureForCloth.brisk: 8,
    bestWeathersTemperatureForCloth.cool: 13,
    bestWeathersTemperatureForCloth.mild: 18,
    bestWeathersTemperatureForCloth.perfect: 25,
    bestWeathersTemperatureForCloth.warm: 29,
    bestWeathersTemperatureForCloth.hot: 33,
    bestWeathersTemperatureForCloth.scorching: 40,
  };

  int get clothTemperature => clothTemperatures[this];
}

enum additionalWeatherConditions { none, snow, rain, hail, wind }

class Cloth {
  final clothType type;
  final Color color;
  final String clothDir;
  final bestWeathersTemperatureForCloth temperature;
  final additionalWeatherConditions conditions;

  Cloth(
      this.type, this.color, this.clothDir, this.temperature, this.conditions);
}
// class Cloth extends m.Table {
//   m.IntColumn get id => integer().autoIncrement()();
//   m.IntColumn get color => integer()();
//   m.TextColumn get clothDir => text()();
//   m.IntColumn get type => integer()();
//   m.IntColumn get clothTemperature => integer()();
//   m.IntColumn get conditions => integer()();
// }

// @m.DataClassName("Category")
// class Categories extends m.Table {
//   m.IntColumn get id => integer().autoIncrement()();
//   m.TextColumn get description => text()();
// }
// -∞ — -10° = Freezing / Frigid

// -9° — 0° = Cold / Nippy

// 1° — 4° = Chilly

// 5° — 8° = Brisk

// 9° — 13° = Cool

// 14° — 18° = Mild / "Coolish"

// 19° — 25° = Perfect / Beautiful / Gorgeous / Nice

// 26° — 29° = Warm

// 30° — 33° = Hot

// 34° — ∞° = Scorching / Roasting / Blazing / Scalding / Sweltering
//https://www.reddit.com/r/EnglishLearning/comments/7o8rdm/the_definitive_scale_of_english_adjectives_to/ (dostep 17.12.2020)
