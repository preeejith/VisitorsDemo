
import 'package:flutter/material.dart';

import 'package:visitorsbook/homepage.dart';
import 'package:visitorsbook/ui/history.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // ignore: prefer_final_fields
  int _selectedIndex = 0;

  List<Widget> _children = <Widget>[];
  @override
  void initState() {
    _children = [
      const HomeScreen(),
      const History(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex], // new
      // ignore: unnecessary_new
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xff5D3FD3),
          textTheme: Theme.of(context).textTheme.copyWith(
                // ignore: prefer_const_constructors
                caption: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: BottomNavigationBar(
            onTap: onTabTapped, //
            currentIndex: _selectedIndex,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.fact_check),
                label: 'Check In',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.view_timeline_sharp),
                label: 'History',
              ),
            ],

            selectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            // ignore: prefer_const_constructors
            selectedLabelStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            // ignore: prefer_const_constructors
            unselectedLabelStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            // ignore: prefer_const_constructors
            unselectedIconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
