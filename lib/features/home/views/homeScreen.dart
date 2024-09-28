import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/home/components/profileAppbar.dart';
import 'package:fire_app/features/home/components/searchbar.dart';
import 'package:fire_app/features/home/components/stackCard.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import GetX for navigation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeScreenAppbar(),
              SizedBox(height: 20.h),
              const Searchbarr(),
              SizedBox(height: 16.h),
              Text(
                "Recommended Recipes",
                style: TTextStyles.heading.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4,
                    (int index) {
                      return InkWell(
                        child: const Stackcard(),
                        onTap: () {
                          Get.toNamed(AppRoutes.recipepage);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
