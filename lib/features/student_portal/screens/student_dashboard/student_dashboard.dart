import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/classroom_screen/classroom_screen.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/profile_picture_widget.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/student_welcome_section.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../controllers/StudentController.dart';
import '../bottom_navbar.dart';
import 'dashboard_grid.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(StudentController());

    List<DashboardGridItem> items = [
      DashboardGridItem(
        label: 'View Classrooms',
        icon: Icons.class_,
        color: Color(0xffF8B195),
        onPressed: () {
          // TODO: Implement action for View Classrooms item
          Get.to(() => ClassroomScreen());
        },
      ),
      DashboardGridItem(
        label: 'Show Leaderboard',
        icon: Icons.leaderboard,
        color: Color(0xffF67280),
        onPressed: () {
          // TODO: Implement action for Show Leaderboard item
        },
      ),
      DashboardGridItem(
        label: 'Progress',
        icon: Icons.bar_chart,
        color: Color(0xffC06C84),
        onPressed: () {
          // TODO: Implement action for Progress item
        },
      ),
      DashboardGridItem(
        label: 'Achievements',
        icon: Icons.emoji_events,
        color: Color(0xff6C5B7B),
        onPressed: () {
          // TODO: Implement action for Achievements item
        },
      ),
    ];

    return Scaffold(

        bottomNavigationBar: Obx(
          () => BottomNavBar(
            selectedIndex: studentController.selectedIndex.value,
            onItemTapped: (index) {
              studentController.selectedIndex.value = index;
              switch(index){
                case 0:
                  Get.toNamed('/student/dashboard');
                  break;
                case 1:
                  Get.toNamed("/student/announcements");
                  break;
                  default:
                    break;
              }
              },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                StudentWelcomeSection(name: "Hasnain", imageUrl: "asdf"),
                SizedBox(
                  height: 400,
                  child: DashboardGrid(
                    items: items,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
