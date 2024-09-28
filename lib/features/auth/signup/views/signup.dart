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

class SignupScreen extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

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
              children: [
                Image.asset(
                  TImages.applogo, // Provide your logo path here
                  height: 150.h, // Adjust size according to your requirement
                  width: 150.w,
                ),
                Text(
                  "Create Account",
                  style: TTextStyles.heading,
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  hintText: "Enter your username",
                  controller: usernameController,
                  fieldName: "Username",
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email or phone number",
                  fieldName: "Email or Phone number",
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
                SizedBox(height: 40.h),
                CustomButton(
                  buttonText: "Create Account",
                  onPressed: _signup,
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.loginScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TTextStyles.subtitle.copyWith(
                          fontSize: 14.sp,
                          color: TColors.darkerGrey,
                        ),
                      ),
                      Text(
                        "Login",
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

  // Signup method
  void _signup() async {
    String username = usernameController.text;
    String email = emailController.text;
    String pass = passwordController.text;

    try {
      User? user = await _auth.signupwithEmailandpass(email, pass);

      if (user != null) {
        print("User is successfully created");
        showSuccessDialog(Get.context!);
      } else {
        print("Some error occurred during signup");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Success dialog box
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                "Registered Successfully",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary, // Corrected color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "OK",
                  style: TTextStyles.subtitle.copyWith(color: TColors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
