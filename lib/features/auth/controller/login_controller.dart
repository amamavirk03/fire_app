import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Declare as regular TextEditingController
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPassController = TextEditingController();

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    forgotPassController.dispose();
    super.onClose();
  }
}
