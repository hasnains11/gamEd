import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../student_portal/screens/bottom_navbar.dart';
import '../../../student_portal/screens/leaderboard_screen/leaderboard_screen.dart';
import '../create_announcements/create_announcement_screen.dart';
import '../teacher_dashboard.dart';
import 'classroom_details.dart';

class ViewClassroomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Classrooms'),
      ),
      bottomNavigationBar:  BottomNavBar(

        selectedIndex: 1,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('classrooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> classrooms = snapshot.data!.docs;
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Classrooms',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: classrooms.length,
                      itemBuilder: (context, index) {
                        var classroom = classrooms[index];
                        String name = classroom['name']??"";
                        String joiningCode = classroom['joiningCode']??"";
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=>ClassroomDetailsScreen(
                                classroomId: classroom.id,
                                className: name,
                                classCode: joiningCode,
                                teacherName: "Teacher Name",
                              ));
                            },
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('Joining Code: $joiningCode'),
                            trailing: IconButton(
                              icon: Icon(Icons.person_add),
                              onPressed: () {
                                _showAddStudentsDialog(classroom.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error retrieving classrooms'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _showAddStudentsDialog(String classroomId) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Students'),
          content: Text('Add students to the selected classroom'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Logic to add students to the classroom using the classroomId
                Navigator.of(context).pop();
              },
            )

          ],
        );
      },
    );
  }
}
