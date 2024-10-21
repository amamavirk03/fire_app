import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisplayScreen extends StatelessWidget {
  final String postId;
  final String title;
  final String description;
  final String portion;
  final String cooktime;
  final List<String> ingredients;
  final String? imageUrl;

  const DisplayScreen({
    super.key,
    required this.postId,
    required this.title,
    required this.description,
    required this.portion,
    required this.cooktime,
    required this.ingredients,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != null
                ? Image.asset(
                    TImages.chicken, // Change this to your desired asset image
                    height: 300.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(TImages.chicken),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TTextStyles.heading.copyWith(fontSize: 30.sp),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: TColors.buttonbackground,
                      borderRadius: BorderRadius.circular(50.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                portion,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: TColors.primary,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Portion',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: TColors.black,
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: TColors.primary,
                            thickness: 1,
                            width: 20.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cooktime,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: TColors.primary,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: TColors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                  SizedBox(height: 24.h),
                  Text(
                    'Ingredients:',
                    style: TTextStyles.heading.copyWith(fontSize: 20.sp),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Text(
                        '- ${ingredients[index]}',
                        style: TTextStyles.subtitle
                            .copyWith(fontSize: 14.sp, color: TColors.black),
                      );
                    },
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
