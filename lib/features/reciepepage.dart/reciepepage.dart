import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, 
              height: 300.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.food1),
                  fit: BoxFit
                      .cover,
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 30.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 20.sp, color: TColors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      decoration: const BoxDecoration(
                        color: TColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.bookmark,
                            size: 24.sp, color: TColors.primary),
                        onPressed: () {
                          // Add save functionality here
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recipe Name',
                        style: TTextStyles.heading.copyWith(fontSize: 20.sp),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 16.sp, color: TColors.white),
                            SizedBox(width: 4.w),
                            Text(
                              '4.5',
                              style: TTextStyles.buttonText
                                  .copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: TColors.grey,
                        child: Image.asset(TImages.chicken),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style:
                                TTextStyles.heading.copyWith(fontSize: 16.sp),
                          ),
                          Text(
                            'johndoe@email.com',
                            style: TTextStyles.subtitle.copyWith(
                                fontSize: 14.sp, color: TColors.darkGrey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        buttonText: 'Follow',
                        backgroundColor: TColors.buttonbackground,
                        textColor: TColors.primary,
                        width: 100.w,
                        onPressed: () {
                          // OnPressed of follow button
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Description',
                    style: TTextStyles.heading.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'This is a delicious recipe that you can easily cook at home. Follow the steps to prepare a mouth-watering dish.',
                    style: TTextStyles.subtitle
                        .copyWith(fontSize: 14.sp, color: TColors.black),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Ingredients',
                    style: TTextStyles.heading.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '• 1 cup flour\n• 2 eggs\n• 1/2 cup sugar\n• 1 tsp vanilla extract\n• 1 cup milk',
                    style: TTextStyles.subtitle
                        .copyWith(fontSize: 14.sp, color: TColors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
