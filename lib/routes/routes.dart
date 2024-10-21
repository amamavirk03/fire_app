import 'package:fire_app/features/auth/model/user_model.dart';
import 'package:fire_app/features/auth/views/login.dart';
import 'package:fire_app/features/auth/views/signup.dart';
import 'package:fire_app/features/home/views/homeScreen.dart';
import 'package:fire_app/features/navigation/navigation.dart';
import 'package:fire_app/features/notification/views/notification.dart';
import 'package:fire_app/features/onboarding/views/onboarding.dart';
import 'package:fire_app/features/postscreen/views/postscreen.dart';
import 'package:fire_app/features/reciepepage.dart/reciepepage.dart';
import 'package:fire_app/features/splash/splashscreen.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetAppRoute {
  List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => const Splashscreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.homeScreen,
        page: () => const HomeScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.notification,
        page: () => const NotificationScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.navigation,
        page: () {
        var  token = UserModel().token.toString();
          // final token = Get.arguments;
          return MainNavigation(token: token);
        },
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.signupScreen,
        page: () => SignupScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.loginScreen,
        page: () => LoginScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.onboardingScreen,
        page: () => const OnboardingScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.notification,
        page: () => const NotificationScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.post,
        page: () {
          final token =
              Get.arguments as String; // Retrieve the token passed as argument
          return PostScreen(token: token); // Pass token to PostScreen
        },
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
      GetPage(
        name: AppRoutes.recipepage,
        page: () => const RecipeScreen(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ];
  }

  //dekh terminal
}
