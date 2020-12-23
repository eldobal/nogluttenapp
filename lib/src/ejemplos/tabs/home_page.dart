import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../ejemplosWidget.dart';
import 'business_tab.dart';
import 'home_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final _textStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final _tabs = <Widget>[
    HomeTab(textStyle: _textStyle),
    BusinessTab(textStyle: _textStyle),
  ];

  //cuando se selecciona una tab se actualiza el _selectedIndex
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _tabs[_selectedIndex],
        ),
      ),
      floatingActionButton: OpenContainer(
        closedBuilder: (context, action) {
          return FloatingActionButton(onPressed: action);
        },
        openBuilder: (context, action) {
          return SelectedItemPage(seletedItem: 1);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
