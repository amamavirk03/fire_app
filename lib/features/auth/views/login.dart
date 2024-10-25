import 'package:fire_app/apis/auth_services/login_post_services.dart';
import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fire_app/common/components/customTextField.dart';
import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 600;
    double horizontalPadding = isWeb ? 50.w : 25.w;
    double verticalPadding = isWeb ? 40.h : 20.h;
    double logoSize = isWeb ? 200.r : 150.r;
    double verticalSpacing = isWeb ? 30.h : 20.h;
    double largeVerticalSpacing = isWeb ? 60.h : 40.h;
    double subtitleFontSize = isWeb ? 16.sp : 14.sp;
    double createAccountFontSize = isWeb ? 18.sp : 16.sp;
    double horizontalGap = isWeb ? 8.w : 5.w;

    return Scaffold(
      backgroundColor: TColors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        TImages.applogo,
                        height: logoSize,
                        width: logoSize,
                      ),
                      Text("Login Account", style: TTextStyles.heading),
                      SizedBox(height: verticalSpacing),
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
                      SizedBox(height: verticalSpacing),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "Enter your password",
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
                      SizedBox(height: verticalSpacing),
                      CustomButton(
                        buttonText: "Login",
                        onPressed: () {
                          UserModel user = UserModel();
                          // if (_formKey.currentState!.validate()) {
                          LoginServices()
                              .login(emailController.text.toString(),
                                  passwordController.text.toString())
                              .then((value) {
                            if (value?.token != null) {
                              user = value!;
                              Get.offAllNamed(AppRoutes.navigation);
                              print("Login successful");
                            }
                          }).onError((error, stackTrace) {
                            print(error.toString());
                          });
                        },
                      ),
                      SizedBox(height: largeVerticalSpacing),
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
                                fontSize: subtitleFontSize,
                                color: TColors.darkerGrey,
                              ),
                            ),
                            SizedBox(width: horizontalGap),
                            Text(
                              "Create Account",
                              style: TTextStyles.subtitle.copyWith(
                                fontSize: createAccountFontSize,
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
          ),
        ),
      ),
    );
  }
}