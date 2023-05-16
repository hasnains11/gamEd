import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamed/features/student_portal/screens/bottom_navbar.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import '../../../teacher_portal/screens/create_announcements/create_announcement_screen.dart';
import '../../../teacher_portal/screens/teacher_dashboard.dart';
import '../leaderboard_screen/leaderboard_screen.dart';
import 'complete_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.appBar, this.selectedindex,this.bottomNavbarItems,this.isTeacherPortal});
final AppBar? appBar;

  int? selectedindex;
  final bool? isTeacherPortal;
  final List<BottomNavigationBarItem>? bottomNavbarItems;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _userData = null;

  @override
  void initState() {
    super.initState();
    // sleep(Duration(seconds: 5));
    _loadUserData();
  }

  void _loadUserData() async {
    print("loading usedata");
    String? email = FirebaseAuth.instance.currentUser?.email;
    print(email);
    final userData =
    await FirebaseFirestore.instance.collection('users').doc(email).get();
    print(userData.data());
    setState(() {
      _userData = userData;
    });
  }

  Widget _buildProfileInfo() {
    if (_userData != null && _userData.exists) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center
        ,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileTag(_userData['role'].toString().toUpperCase()),
          SizedBox(height: 15.0),
          CircleAvatar(
            radius: 50.0,
            backgroundImage: (_userData.data() != null && _userData.data().containsKey('profilePictureUrl'))
                ? NetworkImage(_userData.data()['profilePictureUrl'])
                : NetworkImage('https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
          ),


          SizedBox(height: 20.0),
          Text(
            _userData['userData']['fullName'],
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 13.0),
          Text(
          "Email address",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _userData['email'],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 13.0),
          Text(
            "Phone Number",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _userData['userData']['phoneNo'],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _onCompleteProfilePressed() {
    // TODO: Navigate to the complete profile screen
    Get.to(() => CompleteProfileScreen());
  }

  Widget _buildCompleteProfileButton() {
    if (_userData == null ||
        _userData.exists ||
        !_userData['isProfileComplete']) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: ElevatedButton(
          onPressed: _onCompleteProfilePressed,
          child: Text('Complete Profile'),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildProfileTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:  widget.isTeacherPortal??false ? BottomNavBar(

        selectedIndex: widget.selectedindex??0,
        onItemTapped: (index){
          if(index==0){
            Get.off(()=>TeacherDashboardScreen());
          }
          else if(index==1){
            Get.off(()=>CreateAnnouncementScreen());
          }
          else if(index==2){
            Get.off(()=>LeaderboardScreen(
              appBar: AppBar(
                  title: Text('Leaderboard'),
                  flexibleSpace: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff334D50),
                          Color(0xff45B69C),
                          Color(0xffEFC94C),
                          Color(0xffAB3E5B),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  )
              ),
              selectedindex:2,bottomNavbarItems: [
              BottomNavigationBarItem(
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
              ),

            ],isTeacherPortal: true,));
          }
          else if(index==3){
          }
        },
        items: widget.bottomNavbarItems??[],
      ):null,

      appBar:widget.appBar==null? AppBar(
        title: Text('User Profile'),
        centerTitle: true,
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
      ):widget.appBar,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildProfileInfo(),
                    SizedBox(height: 20.0),
                    _buildCompleteProfileButton(),
                    ElevatedButton(
                      onPressed: () async {
                        // Perform logout functionality here
                    await AuthenticationRepository.instance.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Set the button background color to red
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
