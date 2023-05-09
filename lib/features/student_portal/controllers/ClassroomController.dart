import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../model/Classroom.dart';

class ClassroomController extends GetxController {
  RxList<Classroom> classrooms = RxList<Classroom>([]);

  @override
  void onInit() {
    super.onInit();
    loadClassrooms();
  }



  Future<bool> isUserJoined(String joiningCode) async {
    try {
      // Check if the joining code exists in the classrooms list
      bool isJoined = classrooms.any((classroom) => classroom.joiningCode == joiningCode);
      return isJoined;
    } catch (error) {
      print('Error checking user joined status: $error');
      return false;
    }
  }


  Future<void> leaveClassroom(String classroomId) async {
    try {
      final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

      // Fetch the classroom document
      final classroomDoc = FirebaseFirestore.instance.collection('classrooms').doc(classroomId);

      // Fetch the current student list from the classroom document
      final classroomSnapshot = await classroomDoc.get();
      final students = List<Map<String, dynamic>>.from(classroomSnapshot.data()?['students']);

      // Filter out the current user from the student list
      final updatedStudents = students.where((student) => student['email'] != currentUserEmail).toList();

      // Update the classroom document with the updated student list
      await classroomDoc.set({
        'students': updatedStudents,
      }, SetOptions(merge: true));

      Get.rawSnackbar(
        snackStyle: SnackStyle.FLOATING,
        message: 'Successfully left the classroom!',
        margin: EdgeInsets.all(16),
      );

      // Reload the classrooms after leaving
      loadClassrooms();

      print('Successfully left the classroom!');
    } catch (error) {
      print('Error leaving the classroom: $error');
    }
  }







  Future<void> joinClassroom(String joiningCode) async {
    try {
      // Get the current user
      final currentUser = AuthenticationRepository.instance.currentUser! as Map<String, dynamic>;
      final String? userEmail = FirebaseAuth.instance.currentUser!.email ;
    print("ASDFSA $userEmail");
     bool alreadyJoined= await isUserJoined(joiningCode??"");
     print("ASDFSA $alreadyJoined");
     // Fetch the classroom document based on the joining code
     if(alreadyJoined==true){
       Get.snackbar(
         "Already Joined",
         "You have already joined this classroom",
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red[300],
         colorText: Colors.white,
       );
       return;
     }

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('classrooms')
          .where('joiningCode', isEqualTo: joiningCode)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot classroomDoc = snapshot.docs.first;
        final String classroomId = classroomDoc.id;

        // Update the classroom document by adding the user to the student list
        await FirebaseFirestore.instance
            .collection('classrooms')
            .doc(classroomId)
            .update({
          'students': FieldValue.arrayUnion([
            {
              ...currentUser
              // Add any additional student information here
            },
          ]),
        });
        Get.rawSnackbar(
          snackStyle: SnackStyle.FLOATING,
          message: 'Successfully joined the classroom!',
          margin: EdgeInsets.all(16),
        );
        loadClassrooms();
        print('Successfully joined the classroom!');

      } else {
        Get.snackbar(
          "No Classroom found",
          "NO classroom found with this joining code",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      print('Error joining the classroom: $error');
    }
  }


  void loadClassrooms() async {
  String useremail = FirebaseAuth.instance.currentUser!.email!;
    print(useremail);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('classrooms').
    get();
    List<Classroom> fetchedClassrooms = [];

   querySnapshot.docs.length>0 ? querySnapshot.docs.forEach((doc) {
     print("sdfpsdf asdf");
     print(doc.id);
      var data=doc.data() as Map<String,dynamic>;
      List<Map<String, dynamic>> students = List<Map<String, dynamic>>.from(data['students']);
      bool isStudentInClassroom = students.any((student) => student['email'] == useremail);
      if(isStudentInClassroom){

      Classroom classroom = Classroom(
        id: doc.id,
        joiningCode: data['joiningCode'],
        name: data['name'],
        students: List<Map<String, dynamic>>.from(data['students']),
        teacherEmail: data['teacherEmail'],
        teacherName: data['teacherName'],

     );
      fetchedClassrooms.add(classroom);
      }
   }):"";

   classrooms.value=fetchedClassrooms;

    // classrooms.value = result.docs.map((element) {
    //   var data = element.data();
    //   return (Classroom(
    //       name: data['name'],
    //       teacher: data['teacher'],
    //       students:[]));
    //   // print(element.data());
    // }).toList();

    print(classrooms.value);

    print('classrooms loaded');

  }
}
