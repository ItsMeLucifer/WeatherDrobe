import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherdrobe/viewmodels/First Page VM/current_data_view_model.dart';
import 'package:weatherdrobe/viewmodels/First Page VM/hourly_forecast_view_model.dart';
import 'package:weatherdrobe/viewmodels/VIrtual%20Wardrobe%20VM/Virtual_Wardrobe_View_Model.dart';
import 'package:weatherdrobe/viewmodels/firebase/firebase_auth_View_Model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:weatherdrobe/utilities/wrapper.dart';
import 'package:flutter/services.dart';

final currentData = ChangeNotifierProvider((_) => CurrentDataViewModel());
// final hourlyData = FutureProvider((_) async {
//   final lat = _.watch(currentData).lat;
//   final long = _.watch(currentData).long;
//   return HourlyForecastViewModel(lat ?? 54.516640, long ?? 18.550909);
// });
final hourlyData = ChangeNotifierProvider((_) => HourlyForecastViewModel());
final firebaseAuth =
    ChangeNotifierProvider((_) => FireBaseAuthViewModel.instance());
final virtualWardrobe =
    ChangeNotifierProvider((_) => VirtualWardrobeViewModel());
// final firebaseAuth =
//     ChangeNotifierProvider.autoDispose<FireBaseAuthViewModel>((ref) {pib
// });

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(ProviderScope(child: MyApp()));
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
  // Widget build(BuildContext context) {
  //   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //   return FutureBuilder(
  //     // Initialize FlutterFire:
  //     future: _initialization,
  //     builder: (context, snapshot) {
  //       // Check for errors
  //       if (snapshot.hasError) {
  //         return Scaffold(body: Text('Something went wrong'));
  //       }

  //       // Once complete, show your application
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return MaterialApp(
  //           title: _title,
  //           home: Wrapper(),
  //         );
  //       }

  //       // Otherwise, show something whilst waiting for initialization to complete
  //       return Scaffold(body: Text('Loading...'));
  //     },
  //   );
  // }
}
