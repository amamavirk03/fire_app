import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/home/components/profileAppbar.dart';
import 'package:fire_app/features/home/components/searchbar.dart';
import 'package:fire_app/features/home/components/stackcard.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Hardcoded list of posts to replace Firebase
  final List<Map<String, dynamic>> posts = [
    {
      'title': 'Spaghetti Carbonara',
      'imageUrl': TImages.food1,
      'cookTime': '20 mins',
      'avatarImage': TImages.chicken,
      'userName': 'Chef John',
      'description': 'A delicious spaghetti carbonara recipe',
      'portion': '2 servings',
    },
    {
      'title': 'Chicken Alfredo',
      'imageUrl': TImages.food1,
      'cookTime': '25 mins',
      'avatarImage': TImages.chicken,
      'userName': 'Chef Anna',
      'description': 'Creamy chicken alfredo pasta',
      'portion': '3 servings',
    },
    {
      'title': 'Tacos',
      'imageUrl': TImages.food1,
      'cookTime': '15 mins',
      'avatarImage': TImages.chicken,
      'userName': 'Chef Maria',
      'description': 'Spicy and delicious tacos',
      'portion': '4 servings',
    },
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeScreenAppbar(),
              SizedBox(height: 20.h),
              const Searchbarr(),
              SizedBox(height: 16.h),
              Text(
                "Recommended Posts",
                style: TTextStyles.heading.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(posts.length, (index) {
                    final post = posts[index];

                    String title = post['title'];
                    String imageUrl = post['imageUrl'];
                    String cookTime = post['cookTime'];
                    String avatarImage = post['avatarImage'];
                    String userName = post['userName'];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.recipepage, arguments: {
                          'id': index,
                          'title': title,
                          'imageUrl': imageUrl,
                          'description': post['description'],
                          'portion': post['portion'],
                          'cooktime': cookTime,
                        });
                      },
                      child: StackCard(
                        title: title,
                        imageUrl: imageUrl,
                        cookTime: cookTime,
                        avatarImage: avatarImage, // Pass avatarImage
                        userName: userName, // Pass userName
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
