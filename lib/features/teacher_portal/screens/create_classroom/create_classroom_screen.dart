
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../student_portal/screens/bottom_navbar.dart';
import '../../../student_portal/screens/leaderboard_screen/leaderboard_screen.dart';
import '../create_announcements/create_announcement_screen.dart';
import '../teacher_dashboard.dart';

class CreateClassroomScreen extends StatefulWidget {
  @override
  _CreateClassroomScreenState createState() => _CreateClassroomScreenState();
}

class _CreateClassroomScreenState extends State<CreateClassroomScreen> {
  TextEditingController _classNameController = TextEditingController();
  TextEditingController _joiningCodeController = TextEditingController();

  List<Map<String ,dynamic>> _selectedStudents = [];
  @override
  void dispose() {
    _classNameController.dispose();
    _joiningCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Classroom'),
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
            TextField(
              controller: _classNameController,
              decoration: InputDecoration(
                labelText: 'Classroom Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Add Students'),
              onPressed: () {
                _showAddStudentsDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected Students:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: ListView.builder(
                  itemCount: _selectedStudents.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_selectedStudents[index]['userData']['fullName']),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _selectedStudents.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _generateJoiningCode();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              child: Text('Generate Joining Code'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _joiningCodeController,
              decoration: InputDecoration(
                labelText: 'Joining Code',
                enabled: false,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Create Classroom'),
              onPressed: () {
                _createClassroom();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddStudentsDialog() async {
    List<Map<String,dynamic>> students = await _fetchStudents();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Students'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(students[index]['userData']['fullName']),
                      value: _selectedStudents.contains(students[index]),
                      onChanged: (value) {
                        setState(() {
                          if (value ?? true) {
                            _selectedStudents.add(students[index]);
                          } else {
                            _selectedStudents.remove(students[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<List<Map<String,dynamic>>> _fetchStudents() async {
    List<Map<String,dynamic>> students = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'student')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        var studentName = doc.data() as Map<String,dynamic>;
        students.add(studentName);
      });
    }

    return students;
  }

  Future<String> generateUniqueJoiningCode() async {
    CollectionReference classroomsRef = FirebaseFirestore.instance.collection('classrooms');
    String joiningCode="";

    try {
      // Generate a unique joining code using Firestore's atomic operation
      joiningCode = classroomsRef.doc().id.substring(0, 6);

      // Check if the joining code already exists in Firestore
      QuerySnapshot querySnapshot = await classroomsRef
          .where('joiningCode', isEqualTo: joiningCode)
          .limit(1)
          .get();

      while (querySnapshot.docs.isNotEmpty) {
        // If the code already exists, generate a new code
        joiningCode = classroomsRef.doc().id.substring(0, 6);
        querySnapshot = await classroomsRef
            .where('joiningCode', isEqualTo: joiningCode)
            .limit(1)
            .get();
      }
    } catch (e) {
      print('Error generating joining code: $e');
      // Handle any errors that occur during joining code generation
      // You can show an error message to the user or take appropriate actions
    }
    // _joiningCodeController.text = joiningCode;
    return joiningCode;
  }
  void _generateJoiningCode() async {
     var joiningCode =await generateUniqueJoiningCode();
    _joiningCodeController.text = joiningCode;
  }


  void _createClassroom() async {
    String classroomName = _classNameController.text;
    String joiningCode = _joiningCodeController.text;

    var currentUser = AuthenticationRepository.instance.currentUser;
    String teacherName = currentUser["userData"]["fullName"];
    String teacherEmail = currentUser["email"];

    // Perform classroom creation logic here
    // You can use the classroomName, joiningCode, and _selectedStudents list
    try {
      // Check if the classroom with the same name already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('classrooms').
          where('teacherEmail', isEqualTo: teacherEmail).
          where('name', isEqualTo: classroomName).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Classroom with the same name already exists
        // Show a notification to the user
        Get.snackbar(
          'Error',
          'Classroom with the same name already exists',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Create a new document in the "classrooms" collection
      DocumentReference classroomRef = FirebaseFirestore.instance.collection('classrooms').doc();

      // Prepare the data for the classroom
      Map<String, dynamic> classroomData = {
        'name': classroomName,
        'joiningCode': joiningCode,
        'teacherName': teacherName,
        'teacherEmail': teacherEmail,
        'students': _selectedStudents,
      };

      // Set the data to the document
      await classroomRef.set(classroomData);

      // Show a success notification to the user
      Get.snackbar(
        'Success',
        'Classroom created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Pop the current screen
      Navigator.of(context).pop();
    } catch (e) {
      // Handle any errors that occur during classroom creation
      print('Error creating classroom: $e');
      // Show an error notification to the user
      Get.snackbar(
        'Error',
        'An error occurred while creating the classroom',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }






//   void _createClassroom() {
//     String classroomName = _classNameController.text;
//     String joiningCode = _joiningCodeController.text;
//     // Perform classroom creation logic here
// // You can use the classroomName, joiningCode, and _selectedStudents list
//     var currentUser=AuthenticationRepository.instance.currentUser;
//     String teacherName = currentUser["userData"]["fullName"];
//     String teacherEmail = currentUser["email"];
//
//
//
//     print('Classroom Name: $classroomName');
//     print('Joining Code: $joiningCode');
//     print('Selected Students: $_selectedStudents');
//   }
}
