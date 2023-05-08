import 'package:flutter/material.dart';
import 'package:gamed/features/student_portal/screens/student_dashboard/profile_picture_widget.dart';

import '../../../../repositories/authentication_repository/authentication_repository.dart';

class StudentWelcomeSection extends StatelessWidget {
  final String name;
  final String imageUrl;

  StudentWelcomeSection({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          // Text("Student Dashboard",
          // style: TextStyle(
          //     fontSize: 15
          //
          // ),
          //
          //   textAlign: TextAlign.center,),
          SizedBox(height: 14,),
          Text("Welcome,",
          style: TextStyle(
            fontSize: 22,
          ),),
          SizedBox(height: 7,),


          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ProfilePictureWidget(userId: AuthenticationRepository.instance.firebaseUser.value?.email??"",),
            SizedBox(width: 13  ,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height:14.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ]),
          Row(
            children: [
              SizedBox(width: 16.0),

            ],
          ),
          SizedBox(height: 16.0),
          Text(
            "We're glad to have you on board!",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
