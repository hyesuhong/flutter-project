import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.index});

  final int index;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List routes = ['/', '/users', '/bluetooth'];
  int _index = 0;

  void _onItemTapped(int index) {
    if (index == _index) {
      return;
    }

    setState(() {
      _index = index;
    });

    var route = routes[_index];
    Navigator.pushNamed(context, route);
  }

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bluetooth),
          label: 'bluetooth',
        ),
      ],
      currentIndex: _index,
      // selectedItemColor: Colors,
      onTap: _onItemTapped,
    );
  }
}
