import 'package:flutter/material.dart';
import 'package:gamed/features/authentication/model/UserModel.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    try {
      await _db
          .collection('users')
          .doc(user.email)
          .set(user.toMap())
          .onError((error, stackTrace) =>
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                  backgroundColor: Colors.red,
                ),
              ))
          .whenComplete(() => ScaffoldMessenger.of(Get.context!).showSnackBar(
                const SnackBar(
                  content: Text('Account Created Successfully'),
                  backgroundColor: Colors.green,
                ),
              ));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
