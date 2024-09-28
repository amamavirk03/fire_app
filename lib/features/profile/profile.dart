import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fire_app/common/components/cutomButton.dart';
import 'package:fire_app/common/components/postcard.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/routes/routename.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Define variables to hold user info
  String name = '';
  String email = '';
  String bio = '';
  String profileImage = '';
  int followers = 0;
  int following = 0;
  int postCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Fetch user data on screen load
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('uid123456789') // Replace with current user ID
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'];
          email = userDoc['email'];
          bio = userDoc['bio'];
          profileImage = userDoc['profileImage'];
          followers = userDoc['followers'];
          following = userDoc['following'];
          postCount = userDoc['postcount'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: TColors.primary),
            onPressed: () {
              // Navigate to settings page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: TColors.grey,
                    backgroundImage: profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : null,
                    child: profileImage.isEmpty
                        ? Icon(Icons.person, size: 40.sp, color: TColors.white)
                        : null,
                  ),
                  // Followers count
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        followers.toString(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: TColors.primary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: TColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Following count
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        following.toString(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: TColors.primary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: TColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Post count
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        postCount.toString(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: TColors.primary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Posts',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: TColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              // User info
              Text(name, style: TTextStyles.heading.copyWith(fontSize: 16.sp)),
              SizedBox(height: 2.h),
              Text(email,
                  style: TTextStyles.subtitle
                      .copyWith(fontSize: 16.sp, color: TColors.darkGrey)),
              SizedBox(height: 16.h),
              Text(bio, style: TTextStyles.subtitle.copyWith(fontSize: 14.sp)),
              SizedBox(height: 16.h),
              // Manage profile button
              CustomButton(
                buttonText: "Manage Profile",
                width: double.infinity,
                onPressed: () {
                  // Add manage profile functionality
                },
              ),
              SizedBox(height: 20.h),
              // TabBar
              TabBar(
                controller: _tabController,
                indicatorColor: TColors.primary,
                tabs: const [
                  Tab(text: "Posts"),
                  Tab(text: "Followers"),
                  Tab(text: "Following"),
                  Tab(text: "Settings"),
                ],
              ),
              SizedBox(height: 10.h),
              // TabBar View
              SizedBox(
                height: 1500.h,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Posts Grid
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('userID', isEqualTo: 'uid123456789')
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("No Posts Found"));
                        }
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 5.w,
                            mainAxisSpacing: 10.h,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var postData = snapshot.data!.docs[index];
                            return InkWell(
                              child: PostCard(
                                title: postData['title'],
                                imageUrl: postData['imageUrl'],
                                likes: postData['likes'],
                              ),
                              onTap: () {
                                Get.toNamed(AppRoutes.recipepage);
                              },
                            );
                          },
                        );
                      },
                    ),
                    const Center(child: Text("Followers Content")),
                    const Center(child: Text("Following Content")),
                    const Center(child: Text("Settings Content")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
