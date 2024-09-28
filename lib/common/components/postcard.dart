import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isFavorite = false; // Toggle state for heart icon

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container (without background color)
          Container(
            width: 320.w, // Full width for the image container
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(TImages.food2),
              ),
            ),
          ),
          // Text and icons section with background color
          Container(
            width: 320.w,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color:
                  TColors.lightContainer, // Background color for text section
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: TColors.darkGrey,
                      size: 15.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "186",
                      style: TTextStyles.subtitle.copyWith(
                        color: TColors.darkGrey, // Text color
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.more_vert_rounded,
                  color: TColors.darkGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
