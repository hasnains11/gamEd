import 'package:gamed/features/authentication/screens/select_role_screen.dart';
import 'package:gamed/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';

import '../screens/login_screen/login_screen.dart';

class SplashScreenContoller extends GetxController {
  static SplashScreenContoller get to => Get.find();

  RxBool animate = false.obs;

  startAnimation() async {
    Future.delayed(Duration(seconds: 1), () {
      animate.value = true;
    });
    await Future.delayed(Duration(seconds: 6));
    Get.to(() => RoleSelectionScreen());
  }
}
