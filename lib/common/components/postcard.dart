import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int likes;

  const PostCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.likes,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isFavorite = false; // Toggle state for heart icon

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Use NetworkImage to display the image
        Container(
          width: 320.w, // Full width for the image container
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: const AssetImage(TImages.food1), // Placeholder image
              onError: (exception, stackTrace) {
                // Error handling: fallback to a local image if the network fails
                // print('Error loading image: $exception');
              },
            ),
          ),
        ),
        // Text and icons section with background color
        Container(
          width: 320.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: TColors.lightContainer, // Background color for text section
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display title
              Text(
                widget.title, // Use dynamic title
                style: TTextStyles.heading.copyWith(fontSize: 16.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Handle long titles
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: TColors.primary,
                        size: 15.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.likes.toString(), // Display dynamic likes
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
            ],
          ),
        ),
      ],
    );
  }
}
