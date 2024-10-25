import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavePostCard extends StatefulWidget {
  final String postID; // Post identifier
  final Map<String, dynamic> postDetails;

  String image; // Post details to save in Firestore

  SavePostCard(
      {super.key,
      required this.postID,
      required this.postDetails,
      required this.image});

  @override
  State<SavePostCard> createState() => _SavePostCardState();
}

class _SavePostCardState extends State<SavePostCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // checkIfPostIsSaved();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width > 600 ? 400.w : 320.w,
            height: MediaQuery.of(context).size.width > 600 ? 200.h : 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.image),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width > 600 ? 400.w : 320.w,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: TColors.lightContainer,
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
                      size:
                          MediaQuery.of(context).size.width > 600 ? 20.r : 15.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "186",
                      style: TTextStyles.subtitle.copyWith(
                        color: TColors.darkGrey,
                        fontSize: MediaQuery.of(context).size.width > 600
                            ? 16.sp
                            : 14.sp,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: TColors.primary,
                    size: MediaQuery.of(context).size.width > 600 ? 24.r : 20.r,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
