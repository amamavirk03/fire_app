import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/search/search.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Add settings functionality
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildUserProfile(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent('Recipes', 'My top recipes'),
                  _buildTabContent('Favorites', 'My favorite dishes'),
                  _buildTabContent('Saved', 'Saved for later'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: TabBar(
        controller: _tabController,
        labelColor: TColors.primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: TColors.primary,
        tabs: const [
          Tab(text: "My Recipes"),
          Tab(text: "Favorites"),
          Tab(text: "Saved"),
        ],
      ),
    );
  }

  Widget _buildTabContent(String tabTitle, String description) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            children: [
              customImageTextRow(),
              SizedBox(
                height: 10.h,
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildUserProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30.sp,
                backgroundImage: const AssetImage(
                  TImages.chicken,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3', // Display the dynamic post count
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary, // Primary color from TColors
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Posts', // Text under the number
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black, // Black color from TColors
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '100', // Example number
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary, // Primary color from TColors
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Followers', // Text under the number
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black, // Black color from TColors
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '30', // Example number
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary, // Primary color from TColors
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Following', // Text under the number
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black, // Black color from TColors
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          Text(
            'No bio available',
            style: TTextStyles.subtitle.copyWith(
                color: TColors.darkerGrey, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.sp),
          Text(
            ' ',
            style: TTextStyles.subtitle.copyWith(
                color: TColors.darkerGrey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
