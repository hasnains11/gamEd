import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherProfileScreen extends StatefulWidget {
  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  late String _email;
  late String _fullName;
  late String _college;
  late String _profilePictureUrl;

  Map<String,dynamic> teacherData={};

  @override
  void initState() {
    super.initState();
    fetchTeacherData();
  }

  Future<void> fetchTeacherData() async {
    _email = FirebaseAuth.instance.currentUser!.email!;
    DocumentSnapshot teacherSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_email)
        .get();

    var response=teacherSnapshot.data() as Map<String, dynamic>;

    _fullName = response['fullName'] ?? '';
    // _college = teacherData['college'] ?? '';
    _profilePictureUrl = response['profilePictureUrl'] ?? '';

    setState(() {
        teacherData=response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Profile'),
      ),
      body: Container(
      padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(teacherData['profilePictureUrl']),
              ),
              SizedBox(height: 20.0),
              Text(
                teacherData['userData']['fullName']??"",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.0),
              Text("Email",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height:5.0),

              Text(
                teacherData['email'],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text("Phone Number",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                teacherData['userData']['phoneNo'],
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProfileItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const ProfileItem({
//     Key? key,
//     required this.icon,
//     required this.label,
//     this.value = '',
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 50.0,
//           backgroundImage: NetworkImage(teacherData['profilePictureUrl']),
//         ),
//         SizedBox(height: 20.0),
//         Text(
//           _teacherData['teacherData']['fullName'],
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10.0),
//         Text(
//           _teacherData['email'],
//           style: TextStyle(
//             fontSize: 16.0,
//           ),
//         ),
//         SizedBox(height: 10.0),
//         Text(
//           _teacherData['teacherData']['phoneNo'],
//           style: TextStyle(
//             fontSize: 16.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
