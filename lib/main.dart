import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/viewmodels/First Page/current_data_view_model.dart';
import 'package:weatherdrobe/viewmodels/First Page/hourly_forecast_view_model.dart';
import 'package:weatherdrobe/viewmodels/First%20Page/clothing_chooser.dart';
import 'package:weatherdrobe/viewmodels/Virtual%20Wardrobe/virtual_Wardrobe_View_Model.dart';
import 'package:weatherdrobe/viewmodels/firebase/firebase_auth_View_Model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weatherdrobe/utilities/wrapper.dart';
import 'package:weatherdrobe/viewmodels/Settings%20Page/settings_view_model.dart';
import 'package:weatherdrobe/viewmodels/tools.dart';

final currentData = ChangeNotifierProvider((_) => CurrentDataViewModel());
final hourlyData = ChangeNotifierProvider((_) => HourlyForecastViewModel());
final firebaseAuth =
    ChangeNotifierProvider((_) => FireBaseAuthViewModel.instance());
final virtualWardrobe =
    ChangeNotifierProvider((_) => VirtualWardrobeViewModel());
final clothingChooser = ChangeNotifierProvider((_) => ClothingChooser());
final toolsVM = ChangeNotifierProvider((_) => Tools());
final settingsVM = ChangeNotifierProvider((_) => SettingsViewModel());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(
      child: ProviderScope(
    child: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  static const String _title = 'WeatherDrobe';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Wrapper(),
    );
  }
}
