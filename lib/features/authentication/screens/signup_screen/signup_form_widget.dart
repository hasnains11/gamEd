import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text.dart';
import '../../controllers/SignupController.dart';
import '../../model/UserModel.dart';

class SignUpFormWidget extends StatelessWidget {
  var _selectedRole = 'Student';

  SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Stack(children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  label: Text(tEmail),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  final emailRegex =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

                  final RegExp emailRegExp = RegExp(emailRegex);
                  if (!emailRegExp.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              DropdownButtonFormField<String>(
                value: controller.role.value,
                onChanged: (String? newValue) {
                  controller.role.value = newValue!;
                },
                decoration: InputDecoration(
                  labelText: tRole,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(),
                ),
                items: <String>['Teacher', 'Student', 'Recruiter']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                controller: controller.phoneNo,
                decoration: const InputDecoration(
                  label: Text(tPhoneNo),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final phoneRegex = r'^(?:\+92|0)?\d{10}$';
                  final RegExp phoneRegExp = RegExp(phoneRegex);
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                  label: Text(tPassword),
                  prefixIcon: Icon(Icons.fingerprint),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  final passwordRegex =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';

                  final RegExp passwordRegExp = RegExp(passwordRegex);
                  if (!passwordRegExp.hasMatch(value)) {
                    return 'Password must contain at least 8 characters, 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character (!@#\$&*~)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: tFormHeight - 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("entered signup");
                    print(controller.email.text.trim());
                    print(controller.password.text.trim());
                    if (_formKey.currentState!.validate()) {
                      UserModel user = UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        userData: {
                          'fullName': controller.fullName.text.trim(),
                          'phoneNo': controller.phoneNo.text.trim()
                        },
                        role: controller.role.value.toLowerCase(),
                      );
                      controller.registerUser(user);
                    }
                    ;
                  },
                  child: Text(tSignup.toUpperCase()),
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.isLoading.value
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
      ]),
    );
  }
}
