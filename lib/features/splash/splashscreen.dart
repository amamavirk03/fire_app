import 'package:fire_app/features/splash/controller/splashscreencontroller.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SplashController
    final SplashController splashController = Get.put(SplashController());

    // Start navigation to the next screen
    splashController.startNavigationToHome();

    return Scaffold(
      backgroundColor: TColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              TImages.applogo,
              width: 200.sp, // Use ScreenUtil for responsiveness
              height: 200.sp, // Use ScreenUtil for responsiveness
            ),
          ],
        ),
      ),
    );
  }
}
