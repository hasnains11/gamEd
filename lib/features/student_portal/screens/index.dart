import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/bottom_navbar.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';
import 'Announcements/StudentAnnouncements.dart';
import 'student_dashboard/student_dashboard.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const StudentDashboard(),
    const StudentAnnouncements(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        ElevatedButton(
            onPressed: () async {
              await AuthenticationRepository.instance.logout();
            },
            child: const Text("Logout")),
      ]),
      body: Stack(
        children: _widgetOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final widget = entry.value;
          return Offstage(
            offstage: _selectedIndex != index,
            child: TickerMode(
              enabled: _selectedIndex == index,
              child: widget,
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
