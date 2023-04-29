import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  var a = Get.put(AuthenticationRepository());
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  RxBool loading = false.obs;

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    loading.value = true;
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
    loading.value = false;
    print(error.toString());
    if (error != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
      // Get.showSnackbar(GetSnackBar(
      //   message: error.toString(),
      // ));
    }
  }
}
