import 'package:flutter/material.dart';

final key = new GlobalKey<_NavBarState>();

class NavBar extends StatefulWidget {

  //NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();

}

class _NavBarState extends State<NavBar> {

  int _selectedIndex = 0;
  //int get selectedIndex => _selectedIndex;

  void _onItemTap(int index){
    setState(() => _selectedIndex = index);
  }

  int getSelectedIndex(){
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.no_food),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run_outlined),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wb_sunny),
          label: 'Nutrients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Meds',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTap,
    );
  }
}
