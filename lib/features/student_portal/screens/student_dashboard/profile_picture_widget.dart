import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureWidget extends StatefulWidget {
  final String userId;

  ProfilePictureWidget({required this.userId});

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  late File _imageFile;
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;

  Future<void> _uploadImage(File file) async {
    final ref = _storage.ref().child('profilePictures/${widget.userId}.jpg');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update({'profilePictureUrl': url});
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
    await _uploadImage(_imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        final profilePictureUrl = data['profilePictureUrl'];
        return GestureDetector(
          onTap: _getImage,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: profilePictureUrl != null
                ? NetworkImage(profilePictureUrl)
                : null,
            child: profilePictureUrl == null ? Icon(Icons.person) : null,
          ),
        );
      },
    );
  }
}
