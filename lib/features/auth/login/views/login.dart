import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutomButton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/auth/firebaseauth/firebase_auth_services.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  // Using final keyword for controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 20.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  TImages.applogo,
                  height: 150.h,
                  width: 150.w,
                ),
                Text("Login Account", style: TTextStyles.heading),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  fieldName: "Email",
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Create your password",
                  fieldName: "Password",
                  inputType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  buttonText: "Login",
                  onPressed: () => _login(),
                ),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.signupScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TTextStyles.subtitle.copyWith(
                          fontSize: 14.sp,
                          color: TColors.darkerGrey,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Create Account",
                        style: TTextStyles.subtitle.copyWith(
                          fontSize: 16.sp,
                          color: TColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method for handling login
  void _login() async {
    String email = emailController.text;
    String pass = passwordController.text;

    try {
      User? user = await _auth.signinwithEmailandpass(email, pass);
      if (user != null) {
        print("User successfully logged in");
        Get.toNamed(AppRoutes.navigation); // Navigate to home screen
      } else {
        print("Login failed, please try again");
        Get.snackbar('Error',
            'Login failed, please try again'); // Show snackbar on failure
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', e.toString()); // Show error message
    }
  }
}
