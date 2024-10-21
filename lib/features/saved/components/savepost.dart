import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavePostCard extends StatefulWidget {
  final String postID; // Post identifier
  final Map<String, dynamic> postDetails; // Post details to save in Firestore

  const SavePostCard(
      {super.key, required this.postID, required this.postDetails});

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

  // // Check if the post is already saved in Firestore
  // void checkIfPostIsSaved() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     try {
  //       var snapshot = await FirebaseFirestore.instance
  //           .collection('saved_posts')
  //           .doc(user.uid)
  //           .get();

  //       if (snapshot.exists) {
  //         setState(() {
  //           isFavorite = snapshot.data()?[widget.postID] != null;
  //         });
  //       }
  //     } catch (e) {
  //       print("Error fetching saved posts: $e");
  //       // Handle error appropriately
  //     }
  //   }
  // }

  // // Toggle favorite state and save/remove post in Firestore
  // void onFavoriteToggle() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     setState(() {
  //       isFavorite = !isFavorite;
  //     });

  //     if (isFavorite) {
  //       await FirebaseFirestore.instance
  //           .collection('saved_posts')
  //           .doc(user.uid)
  //           .set({widget.postID: widget.postDetails}, SetOptions(merge: true));
  //     } else {
  //       await FirebaseFirestore.instance
  //           .collection('saved_posts')
  //           .doc(user.uid)
  //           .update({
  //         widget.postID: FieldValue.delete(),
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 320.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(TImages.food1),
              ),
            ),
          ),
          Container(
            width: 320.w,
            padding: EdgeInsets.all(10.sp),
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
                // View count row
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
                        color: TColors.darkGrey,
                      ),
                    ),
                  ],
                ),
                // Bookmark icon with toggle functionality
                IconButton(
                  onPressed: () {},
                  // onFavoriteToggle, // Toggle bookmark state
                  icon: Icon(
                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    color: TColors.primary,
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
