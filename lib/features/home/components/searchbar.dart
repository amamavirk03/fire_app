import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Searchbarr extends StatelessWidget {
  const Searchbarr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        color: TColors
            .lightContainer, // Set the background color to the primary color
        borderRadius: BorderRadius.circular(30.r), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: TColors.lightContainer.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp), // Reduced padding
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: TColors.darkGrey,
              size: 22.sp,
            ),
            SizedBox(width: 8.w), // Reduced spacing
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here",
                  hintStyle: TTextStyles.subtitle.copyWith(
                    fontSize: 14.sp,
                    color: TColors.darkGrey,
                  ),
                  border: InputBorder.none, // Remove default border
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
