import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class Stackcard extends StatefulWidget {
  const Stackcard({super.key});

  @override
  State<Stackcard> createState() => _StackcardState();
}

class _StackcardState extends State<Stackcard> {
  bool isFavorite = false; // Toggle state for heart icon

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: TColors.grey),
        color: TColors.lightContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: 320.w, // Fixed width for the card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section (occupies the full upper side)
          Container(
            width: 320.w, // Fixed width for the image container
            height: 220
                .h, // Increased height for the image to fully cover the upper part
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
          SizedBox(height: 10.h),
          // Row for Clock and Rating
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                clock(),
                rating(),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // Custom widget for profile and save row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ProfileAndSaveRow(
              avatarImage: TImages.chicken,
              userName: "John Doe",
              isFavorite: isFavorite,
              onFavoriteToggle: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Rating widget
  Widget rating() {
    return Container(
      width: 60.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: TColors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
        child: Row(
          children: [
            Icon(
              Icons.star,
              size: 12.sp,
              color: Colors.amber,
            ),
            SizedBox(width: 3.w),
            Text(
              "5.0",
              style: TTextStyles.subtitle.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: TColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Clock widget
  Widget clock() {
    return Container(
      width: 60.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: TColors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 2.sp),
        child: Row(
          children: [
            Icon(
              IconlyLight.time_circle,
              size: 12.sp,
              color: Colors.black,
            ),
            SizedBox(width: 3.w),
            Text(
              "12:09",
              style: TTextStyles.subtitle.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: TColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for profile and save row
class ProfileAndSaveRow extends StatelessWidget {
  final String avatarImage;
  final String userName;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProfileAndSaveRow({
    super.key,
    required this.avatarImage,
    required this.userName,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage(avatarImage),
        ),
        SizedBox(width: 10.w),
        Text(
          userName,
          style: TTextStyles.heading.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onFavoriteToggle,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? TColors.error : TColors.error,
          ),
        ),
      ],
    );
  }
}
