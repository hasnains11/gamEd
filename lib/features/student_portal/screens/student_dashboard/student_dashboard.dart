import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/classroom_screen/classroom_screen.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/profile_picture_widget.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/student_welcome_section.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import '../../controllers/StudentController.dart';
import '../bottom_navbar.dart';
import 'badges_section.dart';
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
          // Get.to(() => ClassroomScreen());
          studentController.selectedIndex.value=6;
        },
      ),
      DashboardGridItem(
        label: 'Show Leaderboard',
        icon: Icons.leaderboard,
        color: Color(0xffF67280),
        onPressed: () {
         studentController.selectedIndex.value=2;
          // TODO: Implement action for Show Leaderboard item
        },
      ),
      DashboardGridItem(
        label: 'Progress',
        icon: Icons.bar_chart,
        color: Color(0xffC06C84),
        onPressed: () {
          // TODO: Implement action for Progress item
          studentController.selectedIndex.value=5;

        },
      ),
      DashboardGridItem(
        label: 'Achievements',
        icon: Icons.emoji_events,
        color: Color(0xff6C5B7B),
        onPressed: () {
          // TODO: Implement action for Achievements item
          studentController.selectedIndex.value=4;
        },
      ),
    ];

    return Scaffold(
        //
        // bottomNavigationBar: Obx(
        //   () => BottomNavBar(
        //     selectedIndex: studentController.selectedIndex.value,
        //     onItemTapped: (index) {
        //       studentController.selectedIndex.value = index;
        //       switch(index){
        //         case 0:
        //           Get.toNamed('/student/dashboard');
        //           break;
        //         case 1:
        //           Get.toNamed("/student/announcements");
        //           break;
        //           default:
        //             break;
        //       }
        //       },
        //   ),
        // ),
      appBar: AppBar(
        flexibleSpace: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffF8B195),
                  Color(0xffC06C84),
                  Color(0xff6C5B7B),
                  Color(0xffF67280),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        leadingWidth: 51,
        primary: true,
        centerTitle: true,
        leading:Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: CircleAvatar(
            foregroundImage:  NetworkImage(
              getProfileImageUrl(),
            ),
          ),
        ),
        title: Text("Student Dashboard"),
      )
          ,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                SizedBox(
                  height: 6,
                ),
                StudentWelcomeSection(name: AuthenticationRepository.instance.currentUser['userData']['fullName'], imageUrl: "asdf"),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 300,
                  child: DashboardGrid(
                    items: items,
                  ),
                ),


              ],
            ),
          ),
        ));
  }

  getProfileImageUrl() => AuthenticationRepository.instance.currentUser['profilePictureUrl']??'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';
}
