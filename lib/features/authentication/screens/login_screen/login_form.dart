import 'package:flutter/material.dart';
import 'package:gamed/features/authentication/controllers/LoginController.dart';
import 'package:gamed/features/authentication/screens/forget_password/forget_password_bottom_sheet.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();
    return Stack(children: [
      Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0),
              //   child: DropdownButtonFormField<String>(
              //     value: loginController.role.value,
              //     onChanged: (String? newValue) {
              //       loginController.role.value = newValue!;
              //     },
              //     decoration: InputDecoration(
              //       labelText: tRole,
              //       prefixIcon: const Icon(Icons.person_outline_rounded),
              //       border: OutlineInputBorder(),
              //     ),
              //     items: <String>['Teacher', 'Student', 'Recruiter']
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //     validator: (value) {
              //       if (value == null) {
              //         return 'Please select a role';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              TextFormField(
                controller: loginController.email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: tEmail,
                    hintText: tEmail,
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: tFormHeight - 20),
              Obx(
                ()=> TextFormField(
                  obscureText: loginController.obscureText.value,
                  controller: loginController.password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: tPassword,
                    hintText: tPassword,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginController.obscureText.value=
                            !loginController.obscureText.value;
                      },
                      icon: Icon(loginController.obscureText.value?
                      Icons.remove_red_eye_sharp:
                      Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: tFormHeight - 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalBottomSheet(context);
                    },
                    child: const Text(tForgetPassword)),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("entered login");
                    loginController.loginUser(
                        loginController.email.text.trim(),
                        loginController.password.text.trim());
                  },
                  child: Text(tLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
      Obx(() => loginController.loading.value
          ? Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ))))
          : const SizedBox()),
    ]);
  }
}
