import 'package:fire_app/features/saved/components/savepost.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // Mock data for saved posts
  Future<List<Map<String, dynamic>>> getSavedPosts() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      {
        'postID': '1',
        'postDetails': {
          'title': 'Delicious Pasta',
          'imageUrl':
              'https://images.unsplash.com/photo-1551183053-bf91a1d81141',
          'cookTime': '30 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/men/1.jpg',
          'userName': 'John Doe',
          'userEmail': 'john@example.com',
          'description':
              'A delicious Italian pasta recipe with rich tomato sauce',
          'portion': '4 servings',
          'ingredients': ['Pasta', 'Tomatoes', 'Olive Oil', 'Garlic', 'Basil'],
          'views': '150'
        }
      },
      {
        'postID': '2',
        'postDetails': {
          'title': 'Healthy Salad',
          'imageUrl':
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
          'cookTime': '15 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/women/2.jpg',
          'userName': 'Jane Smith',
          'userEmail': 'jane@example.com',
          'description': 'Fresh and healthy salad with seasonal vegetables',
          'portion': '2 servings',
          'ingredients': [
            'Lettuce',
            'Tomatoes',
            'Cucumber',
            'Olive Oil',
            'Salt'
          ],
          'views': '200'
        }
      },
      {
        'postID': '3',
        'postDetails': {
          'title': 'Grilled Chicken',
          'imageUrl':
              'https://images.unsplash.com/photo-1532550907401-a500c9a57435',
          'cookTime': '45 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/men/3.jpg',
          'userName': 'Mike Johnson',
          'userEmail': 'mike@example.com',
          'description': 'Perfectly grilled chicken with herbs and spices',
          'portion': '3 servings',
          'ingredients': ['Chicken', 'Herbs', 'Spices', 'Lemon', 'Garlic'],
          'views': '180'
        }
      },
      {
        'postID': '4',
        'postDetails': {
          'title': 'Fresh Smoothie',
          'imageUrl':
              'https://images.unsplash.com/photo-1505252585461-04db1eb84625',
          'cookTime': '5 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/women/4.jpg',
          'userName': 'Sarah Wilson',
          'userEmail': 'sarah@example.com',
          'description': 'Refreshing fruit smoothie perfect for breakfast',
          'portion': '1 serving',
          'ingredients': ['Banana', 'Strawberries', 'Yogurt', 'Honey', 'Milk'],
          'views': '120'
        }
      },
      {
        'postID': '5',
        'postDetails': {
          'title': 'Beef Steak',
          'imageUrl':
              'https://images.unsplash.com/photo-1544025162-d76694265947',
          'cookTime': '25 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/men/5.jpg',
          'userName': 'Robert Brown',
          'userEmail': 'robert@example.com',
          'description': 'Juicy beef steak cooked to perfection',
          'portion': '2 servings',
          'ingredients': ['Beef', 'Salt', 'Pepper', 'Butter', 'Rosemary'],
          'views': '250'
        }
      },
      {
        'postID': '6',
        'postDetails': {
          'title': 'Sushi Platter',
          'imageUrl':
              'https://images.unsplash.com/photo-1553621042-f6e147245754',
          'cookTime': '60 mins',
          'avatarImage': 'https://randomuser.me/api/portraits/women/6.jpg',
          'userName': 'Emily Chen',
          'userEmail': 'emily@example.com',
          'description': 'Homemade sushi platter with various rolls',
          'portion': '4 servings',
          'ingredients': ['Rice', 'Nori', 'Fish', 'Avocado', 'Cucumber'],
          'views': '300'
        }
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: Center(
            child: Text(
          "Recipe Saved",
          style: TextStyle(fontSize: 18.sp),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getSavedPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 15.h,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data![index];
                      return InkWell(
                        child: SavePostCard(
                          image: post['postDetails']['imageUrl'],
                          postID: post['postID'],
                          postDetails: post['postDetails'],
                        ),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.recipepage,
                            arguments: {
                              'postID': post['postID'],
                              'title': post['postDetails']['title'],
                              'imageUrl': post['postDetails']['imageUrl'],
                              'cookTime': post['postDetails']['cookTime'],
                              'avatarImage': post['postDetails']['avatarImage'],
                              'userName': post['postDetails']['userName'],
                              'userEmail': post['postDetails']['userEmail'],
                              'description': post['postDetails']['description'],
                              'portion': post['postDetails']['portion'],
                              'ingredients': post['postDetails']['ingredients'],
                              'isSaved': true,
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  "No saved posts yet.",
                  style: TextStyle(fontSize: 16.sp),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}