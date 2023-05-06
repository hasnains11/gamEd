import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamed/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../student_portal/screens/index.dart';
import '../../student_portal/screens/student_dashboard/student_dashboard.dart';
import '../../teacher_portal/screens/teacher_dashboard.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthenticationRepository());

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(auth.firebaseUser.value?.email??"fakeEmail@gmal.com")
          .snapshots(),
      builder: (context, snapshot) {
        print(auth.firebaseUser.value?.email);
        AuthenticationRepository.instance.setCurrentUser(snapshot.data?.data());
        print(snapshot.data?.data());
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.data == null || snapshot.data!.data() == null) {
          if(auth.firebaseUser.value == null){
            return WelcomeScreen();
          }
          return Center(
            child: CircularProgressIndicator(),
          );


        }else{
        // print(auth.firebaseUser.value!.email);
        // print(snapshot.data!.data().toString());
        // if (snapshot.data!.data() == null) {
        //   return Text("No User found");
        // }
        final data = snapshot.data!.data() as Map<String, dynamic>;

        var role = data['role'].toString().toLowerCase().trim();
        if (data.containsKey('role') && role == "student") {
          return  IndexPage();
        } else if (data.containsKey('role') && role == "teacher") {
          return TeacherDashboardScreen();
        } else if (data.containsKey('role') && role == "recruiter") {
          return Text("Recruiter");
        }
        return Text("No User found");
      }},
    );
  }
}
