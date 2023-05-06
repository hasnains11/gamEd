import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamed/repositories/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

import 'complete_profile_screen.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _userData=null;

  @override
  void initState() {
    super.initState();
    sleep(Duration(seconds: 5));
    _loadUserData();
  }

  void _loadUserData() async {
    print("loading user data");
    String? email=FirebaseAuth.instance.currentUser?.email;
    print(email);
    final userData = await FirebaseFirestore.instance.collection('users')
        .doc(email).get();
    print(userData.data());
    setState(() {
      _userData = userData;
    });
  }

  Widget _buildProfileInfo() {
    if (_userData != null && _userData.exists) {
      return Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(_userData['profilePictureUrl']),
          ),
          SizedBox(height: 20.0),
          Text(
            _userData['userData']['fullName'],
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            _userData['email'],
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
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
    if (_userData == null || !_userData.exists || !_userData['isProfileComplete']) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            _buildProfileInfo(),
            SizedBox(height: 20.0),
            _buildCompleteProfileButton(),
          ],
        ),
      ),
    );
  }
}
