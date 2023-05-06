import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/controllers/StudentController.dart';
import 'package:gamed/features/student_portal/screens/bottom_navbar.dart';
import 'package:gamed/features/student_portal/screens/classroom_screen/classroom_screen.dart';
import 'package:get/get.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';
import 'Announcements/StudentAnnouncements.dart';
import 'StudentProgress/student_progress_screen.dart';
import 'achievements_screen.dart';
import 'leaderboard_screen/leaderboard_screen.dart';
import 'student_dashboard/student_dashboard.dart';
import 'user_profile/student_profile.dart';

class IndexPage extends StatefulWidget {
  static List<Widget> _widgetOptions = <Widget>[
    StudentDashboard(),
    StudentAnnouncements(),
    LeaderboardScreen(),
    ProfileScreen(),
    AchievementScreen(),
    StudentProgressScreen(),
    ClassroomScreen()
  ];

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _studentController = Get.put(StudentController());

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
      body: Obx(()=>
         Stack(
          children: IndexPage._widgetOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final widget = entry.value;
            return Offstage(
              offstage: index!= _studentController.selectedIndex.value,
              child: TickerMode(
                enabled: index == _studentController.selectedIndex.value,
                child: widget,
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Obx(()=>
         BottomNavBar(
          onItemTapped: (int index){
            // setState(() {
            _studentController.selectedIndex.value = index;
          // }
            },
          selectedIndex: _studentController.selectedIndex.value>3 ?0 : _studentController.selectedIndex.value,
           items:[
             BottomNavigationBarItem(
               icon: Icon(Icons.dashboard),
               label: 'Dashboard',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.announcement),
               label: 'Announcement',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.leaderboard),
               label: 'Leaderboard',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.person),
               label: 'Profile',
             ),
           ]

         ),
      ),
    );
  }
}
