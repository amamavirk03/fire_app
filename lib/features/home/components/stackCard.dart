import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String cookTime;
  final String avatarImage;
  final String userName;

  const StackCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.cookTime,
    required this.avatarImage,
    required this.userName,
  });

  @override
  State<StackCard> createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  bool isFavorite = false;

  // Toggle state for the bookmark icon
  void onFavoriteToggle() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: TColors.grey),
        color: TColors.lightContainer,
        borderRadius: BorderRadius.circular(16.r),
      ),
      width: 320.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Container(
            width: 320.w,
            height: 220.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text(
                    widget.title,
                    style: TTextStyles.heading.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Profile and Save Row
                ProfileAndSaveRow(
                  avatarImage: widget.avatarImage,
                  userName: widget.userName,
                  isFavorite: isFavorite,
                  onFavoriteToggle: onFavoriteToggle,
                ),
              ],
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
            color: TColors.error,
          ),
        ),
      ],
    );
  }
}
