import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/bottom_navbar.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/profile_picture_widget.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../firestore_services.dart';
import '../../student_portal/screens/leaderboard_screen/leaderboard_screen.dart';
import '../../student_portal/screens/user_profile/student_profile.dart';
import '../teacher_profile/teacher_profile.dart';
import 'create_announcements/create_announcement_screen.dart';
import 'create_classroom/create_classroom_screen.dart';
import 'view_classrooms/view_classrooms.dart';

class TeacherDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = AuthenticationRepository.instance.currentUser;
//     print(currentUser['userData']['fullName']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
            ),
            child: Row(
              children: [
                Icon(Icons.logout,
                color: Colors.red,
                size: 22,
                ),
                Text("Logout",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            onPressed: () async {
              await AuthenticationRepository.instance.logout();
            },
          ),
        ],
      ),
      bottomNavigationBar:  BottomNavBar(

        selectedIndex: 0,
        onItemTapped: (index){
          if(index==0){
            Get.off(()=>TeacherDashboardScreen());
          }
          else if(index==1){
            Get.off(()=>CreateAnnouncementScreen());
          }
          else if(index==2){
            Get.off(()=>LeaderboardScreen(selectedindex:2,));
          }
          else if(index==3){
            Get.to(()=> TeacherProfileScreen());
            // Get.to(()=>ProfilePictureWidget());
          }
        },
        items: [ BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Classroom',
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGreetingSection(currentUser['email'],currentUser['userData']['fullName']),
            SizedBox(height: 16.0),
            _buildFeatureCard(
              icon: Icons.class_,
              title: 'Create Classroom',
              onTap: () {
                // Handle create classroom action
                Get.off(()=>CreateClassroomScreen());
              },
            ),
            SizedBox(height: 16.0),
            _buildFeatureCard(
              icon: Icons.view_list,
              title: 'View Classrooms',
              onTap: () {
                // Handle view classrooms action
              Get.off(()=>ViewClassroomScreen() );

              },
            ),
            SizedBox(height: 16.0),
            _buildFeatureCard(
              icon: Icons.emoji_events,
              title: 'View Leaderboard',
              onTap: () {
                // Handle view leaderboard action
                Get.off(()=>LeaderboardScreen(selectedindex: 2,));
              },
            ),

              SizedBox(height: 16.0),
            _buildFeatureCard(
              icon: Icons.announcement,
              title: 'Create Announcement',
              onTap: () {
                Get.off(()=>CreateAnnouncementScreen());
                // Handle create announcement action
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 36.0,
                color: Colors.blue,
              ),
              SizedBox(width: 16.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _buildGreetingSection(String userEmail, String name) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ProfilePictureWidget(userId:userEmail),
      // CircleAvatar(
      //   radius: 40.0,
      //   backgroundImage: AssetImage(imageAddress),
      // ),
      SizedBox(width: 16.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, ',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Spacer(),
      Icon(
        Icons.notifications,
        size: 30.0,
      ),
    ],
  );
}




// class TeacherDashboardScreen extends StatefulWidget {
//   @override
//   State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
// }
//
// class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
//   var user;
//
//
//   @override
//   Widget build(BuildContext context) {
//     var currentUser = AuthenticationRepository.instance.currentUser;
//     print(currentUser['userData']['fullName']);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Teacher Dashboard'),
//       ),
//       bottomNavigationBar: BottomNavBar(
//
//         selectedIndex: 0,
//         onItemTapped: (index){
//         },
//         items: [ BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard),
//           label: 'Classroom',
//         ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.announcement),
//             label: 'Announcement',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.leaderboard),
//             label: "Leaderboard",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome, ${currentUser['userData']['fullName']}',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildMetricCard(
//                   context,
//                   title: 'Total Students',
//                   value: '50',
//                   icon: Icons.people,
//                 ),
//                 _buildMetricCard(
//                   context,
//                   title: 'Total Classes',
//                   value: '10',
//                   icon: Icons.class_,
//                 ),
//                 _buildMetricCard(
//                   context,
//                   title: 'Attendance Rate',
//                   value: '80%',
//                   icon: Icons.check_circle,
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.0),
//             Text(
//               'Class Performance',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//         GridView.count(
//           crossAxisCount: 3,
//           mainAxisSpacing: 16.0,
//           crossAxisSpacing: 16.0,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           children: [
//             _buildMenuItem(
//               context,
//               icon: Icons.add_box,
//               label: 'Create Classroom',
//               onTap: () {
//                 // Handle create classroom action
//               },
//             ),
//             _buildMenuItem(
//               context,
//               icon: Icons.person_add,
//               label: 'Add Students',
//               onTap: () {
//                 // Handle add students action
//               },
//             ),
//             _buildMenuItem(
//               context,
//               icon: Icons.edit,
//               label: 'Edit Curriculum',
//               onTap: () {
//                 // Handle edit curriculum action
//               },
//
//             ),
//           ],
//         ),],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMetricCard(
//       BuildContext context, {
//         required String title,
//         required String value,
//         required IconData icon,
//       }) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.3,
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(icon),
//               SizedBox(height: 16.0),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 value,
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//       setState(() {
//           user=fetchUser();
//           // print(user);
//       });
//     }
// }
// Widget _buildMenuItem(BuildContext context,
//     {required IconData icon, required String label, required Function() onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Card(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 32.0,
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             label,
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
//
// class Performance {
//   final String className;
//   final int score;
//
//   Performance(this.className, this.score);
// }
