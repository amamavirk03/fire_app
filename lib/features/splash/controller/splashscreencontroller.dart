import 'package:fire_app/features/onboarding/onboarding.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // This function handles navigation after a delay
  void startNavigationToHome() async {
    // Wait for 3 seconds (adjust as per requirement)
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to MainNavigation (replaces the splash screen)
    Get.offAll(() => const OnboardingScreen());
  }
}
