import 'package:fire_app/features/auth/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var isLastPage = false.obs;

  void onPageChanged(int index) {
    if (index == 2) {
      isLastPage(true);
    } else {
      isLastPage(false);
    }
  }

  void navigateToHome() {
    Get.offAll(() => LoginScreen());
  }
}
