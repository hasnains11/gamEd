import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _semesterController = TextEditingController();
  final _collegeController = TextEditingController();

  void _saveProfile() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Get the current user's email
    String? email = FirebaseAuth.instance.currentUser?.email;

    // Save the profile data to Firestore
    await FirebaseFirestore.instance.collection('users').doc(email).update({
      'userData.semester': _semesterController.text,
      'userData.college': _collegeController.text,
      'isProfileComplete': true,
    });

    // Navigate back to the ProfileScreen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(
                  labelText: 'Semester',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your semester.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _collegeController,
                decoration: InputDecoration(
                  labelText: 'College',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your college.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
