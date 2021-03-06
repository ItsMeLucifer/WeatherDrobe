import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weatherdrobe/main.dart';
import 'package:weatherdrobe/widgets/First Page Widgets/character_model.dart';
import 'package:weatherdrobe/widgets/First Page Widgets/current_weather_display.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30);
  static const Color secondaryColor = Color.fromRGBO(200, 200, 200, 1);
  static const Color primaryColor = Color.fromRGBO(220, 220, 220, 1);
  @override
  initState() {
    super.initState();
    context.read(currentData).getCurrentPosition();
    context.read(hourlyData).getCurrentPosition();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(waterDropColor: primaryColor),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CurrentWeatherDisplay(),
                    Row(
                      children: [
                        Column(
                          children: [
                            Card(
                              child: Container(
                                child: Text(
                                  '⌚',
                                  style: optionStyle,
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              color: secondaryColor,
                            ),
                            Card(
                              child: Container(
                                child: Text(
                                  '🌂',
                                  style: optionStyle,
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              color: secondaryColor,
                            ),
                            Card(
                              child: Container(
                                child: Text(
                                  '💍',
                                  style: optionStyle,
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              color: secondaryColor,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Card(
                            child: Container(
                              width: 275,
                              height: 480,
                              child: CharacterModel(),
                            ),
                            color: primaryColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
