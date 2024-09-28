import 'package:fire_app/common/components/cutomButton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/onboarding/controller/onboardingcontroller.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:fire_app/utils/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({ super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the OnboardingController using GetX
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.onPageChanged(index); // Update the page index
            },
            children: [
              buildPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              buildPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              buildPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          Positioned(
            bottom: 80.sp,
            left: 20.sp,
            right: 20.sp,
            child: Obx(() => controller.isLastPage.value
                ? SizedBox(
                    width: double.infinity.w,
                    height: 50.h,
                    child: CustomButton(
                      buttonText: TTexts.onBoardingbuttontext,
                      onPressed: () {
                        controller
                            .navigateToHome();
                      },
                    ),
                  )
                : Container()),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotWidth: 8.w,
                  dotHeight: 8.h,
                  dotColor: TColors.grey,
                  activeDotColor: TColors.primary, // Indicator color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      {required String image,
      required String title,
      required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250.h),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TTextStyles.heading,
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
