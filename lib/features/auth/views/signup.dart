import 'package:fire_app/apis/auth_services/post_signup_services.dart';
import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future<void> _storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with design size
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // Standard design size
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      backgroundColor: TColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 20.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  TImages.applogo,
                  height: 0.18.sh, // 18% of screen height
                  width: 0.4.sw,  // 40% of screen width
                ),
                Text(
                  "Create Account",
                  style: TTextStyles.heading,
                ),
                SizedBox(height: 30.h),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "Enter your username",
                          controller: _nameController,
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
                          controller: _emailController,
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
                          controller: _passwordController,
                          hintText: "Create your password",
                          fieldName: "Password",
                          inputType: TextInputType.text,
                          obscureText: false,
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
                        CustomTextField(
                          controller: _confirmpasswordController,
                          hintText: "confirm your password",
                          fieldName: "confirm Password",
                          inputType: TextInputType.text,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter same password';
                            } else if (_passwordController ==
                                _confirmpasswordController) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                SizedBox(height: 40.h),
                CustomButton(
                    buttonText: "Create Account",
                    onPressed: () {
                      UserModel user = UserModel();

                      SignupServices()
                          .signup(
                              _nameController.text.toString(),
                              _emailController.text.toString(),
                              _passwordController.text.toString(),
                              _confirmpasswordController.text.toString())!
                          .then((value) {
                        if (value != null) {
                          _storeToken(value.token!);
                          showSuccessDialog(context);
                        }
                      }).onError((error, stackTrace) {
                        print(error.toString());
                      });
                    }),
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60.r,
              ),
              SizedBox(height: 20.h),
              Text(
                "Registered Successfully",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
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