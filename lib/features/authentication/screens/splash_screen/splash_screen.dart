import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/SplashScreenController.dart';

class SplashScreen extends StatelessWidget {
  final splashController = Get.put(SplashScreenContoller());
  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => AnimatedRotation(
                      duration: Duration(milliseconds: 500),
                      turns: splashController.animate.value ? 1 : 0,
                      child: AnimatedOpacity(
                          duration: Duration(milliseconds: 700),
                          opacity: splashController.animate.value ? 1 : 0,
                          child: Image.asset('assets/images/gamed_logo.png'))),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              child: Image.asset(
                'assets/images/welcome_character.png',
                height: 250,
              ),
              curve: Curves.bounceIn,
              right: splashController.animate.value ? -86 : -200,
              bottom: 0,
              duration: Duration(milliseconds: 1200),
            ),
          ),
        ]),
      ),
    );
  }
}
