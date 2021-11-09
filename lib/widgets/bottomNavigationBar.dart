import 'package:flutter/material.dart';
import 'package:weatherdrobe/pages/SettingsPage.dart';
import 'package:weatherdrobe/pages/VirtualWardrobe.dart';

import '../pages/FirstPage.dart';

class BottomNaviBar extends StatefulWidget {
  BottomNaviBar({Key key}) : super(key: key);

  @override
  _BottomNaviBar createState() => _BottomNaviBar();
}

class _BottomNaviBar extends State<BottomNaviBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    FirstPage(),
    VirtualWardrobe(),
    Settings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background2.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.none,
              scale: 5.4),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Clothing model',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Virtual Wardrobe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
    );
  }
}
