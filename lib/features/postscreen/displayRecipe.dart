import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayScreen extends StatelessWidget {
  final String title;
  final String description;
  final String portion;
  final String cooktime;
  final List<String> ingredients;
  final String? imageUrl; // Add imageUrl as a parameter

  const DisplayScreen({
    super.key,
    required this.title,
    required this.description,
    required this.portion,
    required this.cooktime,
    required this.ingredients,
    this.imageUrl,
// Optional imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl!,
                    height: 300.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(TImages.food1),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TTextStyles.heading.copyWith(fontSize: 30.sp),
                    ),
                    SizedBox(height: 16.h),
                    // Divider(
                    //   color: TColors.primary,
                    //   thickness: 2.sp,
                    // ),
                    Container(
                      width: double.infinity, // Full width
                      height: 60.h, // Height of 200
                      decoration: BoxDecoration(
                        color: TColors
                            .buttonbackground, // Background color from TColors
                        borderRadius:
                            BorderRadius.circular(50.sp), // Border radius of 50
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First portion
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  portion, // Example number
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: TColors
                                        .primary, // Primary color from TColors
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Portion', // Text under the number
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: TColors
                                        .black, // Black color from TColors
                                  ),
                                ),
                              ],
                            ),

                            // Divider
                            VerticalDivider(
                              color: TColors.primary, // Divider color
                              thickness: 1,
                              width: 20.w,
                              // Spacing between portions
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cooktime, // Example number
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: TColors
                                        .primary, // Primary color from TColors
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Time', // Text under the number
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: TColors
                                        .black, // Black color from TColors
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Description',
                      style: TTextStyles.heading.copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      description,
                      style: TTextStyles.subtitle
                          .copyWith(fontSize: 14.sp, color: TColors.black),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'Ingredients:',
                      style: TTextStyles.heading.copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(height: 8.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ingredients.map((ingredient) {
                        return Text(
                          "- $ingredient",
                          style: TTextStyles.subtitle
                              .copyWith(fontSize: 14.sp, color: TColors.black),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24.h),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
