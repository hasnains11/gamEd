import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';
import '../../../repositories/user_repository/user_repository.dart';
import '../model/UserModel.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  RxString role = 'Student'.obs;
  RxBool isLoading = false.obs;
  //Call this Function from Design & it will do the rest
  void registerUser(UserModel user) async {
    isLoading.value = true;
    String? error = await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(user.email, user.password, user.role)
        .then((value) async {
      await userRepo.createUser(user);
    });
    isLoading.value = false;
    print(error.toString());
    if (error != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }
}
