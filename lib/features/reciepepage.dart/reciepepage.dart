import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/features/search/search.dart';
import 'package:flutter/material.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecipeScreen extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  RecipeScreen({
    super.key,
    required this.recipeData, 
  })  : title = recipeData['title'] ?? '',
        imageUrl = recipeData['imageUrl'] ?? '',
        cookTime = recipeData['cookTime'] ?? '',
        avatarImage = recipeData['avatarImage'] ?? '',
        userName = recipeData['userName'] ?? '',
        useremail = recipeData['userEmail'] ?? '',
        description = recipeData['description'] ?? '',
        portion = recipeData['portion'] ?? '',
        ingredients = recipeData['ingredients'] ?? [];
  final String title;
  final String imageUrl;
  final String cookTime;
  final String avatarImage;
  final String userName;
  final String useremail;
  final String description;
  final String portion;
  final List<String> ingredients;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final List<Recipe> recipes = [
    Recipe(
      name: 'Crispy Fried Chicken',
      imageUrl: 'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58',
      duration: '45 mins',
      description: 'Crispy and juicy fried chicken with special seasoning',
      ingredients: [
        '1 whole chicken',
        '2 cups flour',
        '1 tsp salt',
        '1 tsp black pepper',
        'Vegetable oil for frying'
      ],
      instructions: [
        'Clean the chicken and cut into pieces',
        'Mix flour with seasonings',
        'Coat chicken pieces with flour mixture',
        'Deep fry until golden brown'
      ],
      avatarImage: 'https://randomuser.me/api/portraits/men/1.jpg',
      userName: 'John Doe',
      userEmail: 'john@example.com',
      portion: '4 servings',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 1.sw,
              height: 0.37.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.027.sw,
                  vertical: 0.037.sh,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 20.sp, color: TColors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 0.043.sw),
                      decoration: const BoxDecoration(
                        color: TColors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.043.sw,
                vertical: 0.012.sh,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: TTextStyles.heading.copyWith(fontSize: 20.sp),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.021.sw,
                          vertical: 0.005.sh,
                        ),
                        decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 16.sp, color: TColors.white),
                            SizedBox(width: 0.011.sw),
                            Text(
                              widget.recipeData['rating']?.toString() ?? '0.0',
                              style: TTextStyles.buttonText.copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.02.sh),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: TColors.grey,
                        backgroundImage: NetworkImage(widget.avatarImage),
                      ),
                      SizedBox(width: 0.032.sw),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: TTextStyles.heading.copyWith(fontSize: 16.sp),
                          ),
                          Text(
                            widget.useremail,
                            style: TTextStyles.subtitle.copyWith(
                              fontSize: 14.sp,
                              color: TColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        buttonText: 'Follow',
                        backgroundColor: TColors.buttonbackground,
                        textColor: TColors.primary,
                        width: 0.27.sw,
                        onPressed: () {
                          // OnPressed of follow button
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 0.03.sh),
                  Text(
                    'Description',
                    style: TTextStyles.heading.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 0.01.sh),
                  Text(
                    widget.description,
                    style: TTextStyles.subtitle.copyWith(
                      fontSize: 14.sp,
                      color: TColors.black,
                    ),
                  ),
                  SizedBox(height: 0.03.sh),
                  Text(
                    'Ingredients',
                    style: TTextStyles.heading.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 0.01.sh),
                  Text(
                    widget.ingredients.join(', '),
                    style: TTextStyles.subtitle.copyWith(
                      fontSize: 14.sp,
                      color: TColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}