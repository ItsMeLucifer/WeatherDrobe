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
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Model ubioru',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Wirtualna Szafa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ustawienia',
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
