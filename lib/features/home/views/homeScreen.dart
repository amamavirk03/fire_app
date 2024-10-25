import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/home/components/profileAppbar.dart';
import 'package:fire_app/features/home/components/searchbar.dart';
import 'package:fire_app/features/home/components/stackcard.dart';
import 'package:fire_app/routes/routename.dart';
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
      'imageUrl':
          'https://images.unsplash.com/photo-1546549032-9571cd6b27df?ixlib=rb-4.0.3',
      'cookTime': '20 mins',
      'avatarImage': 'https://randomuser.me/api/portraits/men/1.jpg',
      'userName': 'Chef John',
      'description': 'A delicious spaghetti carbonara recipe',
      'portion': '2 servings',
      'ingredients': 'Spaghetti, eggs, bacon, parmesan cheese',
      'email': 'john@example.com',
    },
    {
      'title': 'Chicken Alfredo',
      'imageUrl':
          'https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?ixlib=rb-4.0.3',
      'cookTime': '25 mins',
      'avatarImage': 'https://randomuser.me/api/portraits/women/2.jpg',
      'userName': 'Chef Anna',
      'description': 'Creamy chicken alfredo pasta',
      'portion': '3 servings',
      'ingredients': 'Chicken, pasta, Alfredo sauce, parmesan cheese',
      'email': 'anna@example.com',
    },
    {
      'title': 'Tacos',
      'imageUrl':
          'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?ixlib=rb-4.0.3',
      'cookTime': '15 mins',
      'avatarImage': 'https://randomuser.me/api/portraits/women/3.jpg',
      'userName': 'Chef Maria',
      'description': 'Spicy and delicious tacos',
      'portion': '4 servings',
      'ingredients': 'Tortillas, chicken, salsa, cheese, lettuce',
      'email': 'maria@example.com',
    },
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with design size
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // Standard mobile design size
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 40.h,
            horizontal: MediaQuery.of(context).size.width > 600 ? 30.w : 15.w,
          ),
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
                  fontSize:
                      MediaQuery.of(context).size.width > 600 ? 24.sp : 18.sp,
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
                    String description = post['description'];
                    String portion = post['portion'];
                    List<String> ingredients =
                        (post['ingredients'] as String).split(', ');
                    String email = post['email'];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.recipepage, arguments: {
                          'id': index,
                          'title': title,
                          'imageUrl': imageUrl,
                          'description': description,
                          'portion': portion,
                          'cooktime': cookTime,
                          'userName': userName,
                          'userEmail': email,
                          'ingredients': ingredients,
                          'avatarImage': avatarImage,
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width > 600
                              ? 20.w
                              : 10.w,
                        ),
                        child: StackCard(
                          title: title,
                          imageUrl: NetworkImage(imageUrl),
                          cookTime: cookTime,
                          avatarImage: avatarImage,
                          userName: userName,
                        ),
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
