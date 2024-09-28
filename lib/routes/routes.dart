import 'package:fire_app/features/auth/login/views/login.dart';
import 'package:fire_app/features/auth/signup/views/signup.dart';
import 'package:fire_app/features/home/views/homeScreen.dart';
import 'package:fire_app/features/navigation/navigation.dart';
import 'package:fire_app/features/notification/views/notification.dart';
import 'package:fire_app/features/onboarding/onboarding.dart';
import 'package:fire_app/features/postscreen/postscreen.dart';
import 'package:fire_app/features/reciepepage.dart/reciepepage.dart';
import 'package:fire_app/features/splash/splashscreen.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:get/get.dart';

class GetAppRoute {
  List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoutes.splashScreen, // Route for splash screen
        page: () => const Splashscreen(), // Splash screen page
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
        // Ensure arguments are passed if needed
      ),
      GetPage(
        name: AppRoutes.navigation,
        page: () => const MainNavigation(), // MainNavigation for other screens
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
        page: () => const PostScreen(),
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
}
