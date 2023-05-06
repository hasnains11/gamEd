import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  List<BottomNavigationBarItem> items;
  BottomNavBar({required this.selectedIndex, required this.onItemTapped,required this.items});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 13,

      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
      items:widget.items,
    );
  }
}
// BottomNavigationBarItem(
// icon: Icon(Icons.dashboard),
// label: 'Dashboard',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.announcement),
// label: 'Announcement',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.leaderboard),
// label: 'Leaderboard',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.person),
// label: 'Profile',
// ),