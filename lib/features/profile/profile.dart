import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/common/components/postcard.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? userID; // Declare userID
  int postCount = 0; // To store the dynamic post count

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: Text("Profile Page", style: TTextStyles.heading),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buildUserProfile(),
              SizedBox(
                height: 10.sp,
              ),
              CustomButton(buttonText: "Edit profile ", onPressed: () {}),
              SizedBox(
                height: 10.sp,
              ),
              buildUserPosts()
            ],
          ),
        ),
      ),
    );
  }

  // Widget to fetch and display the user's posts
  Widget buildUserPosts() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 10.sp,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const PostCard(
          title: 'No title',
          imageUrl: TImages.food1,
          likes: 3,
        );
      },
    );
  }
}
