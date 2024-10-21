import 'package:fire_app/features/onboarding/views/onboarding.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // This function handles navigation after a delay
  void startNavigationToHome() async {
    // Wait for 3 seconds (adjust as per requirement)
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to the OnboardingScreen and remove the splash screen from the stack
    Get.offAll(() => const OnboardingScreen());
  }
}
