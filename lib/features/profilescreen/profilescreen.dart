import 'package:fire_app/common/components/cutombutton.dart';
import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/search/search.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen>
    with SingleTickerProviderStateMixin {
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
    Recipe(
      name: 'Spaghetti Carbonara',
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3',
      duration: '30 mins',
      description: 'Classic Italian pasta dish with creamy sauce',
      ingredients: [
        'Spaghetti',
        'Eggs',
        'Pecorino Romano',
        'Pancetta',
        'Black pepper'
      ],
      instructions: [
        'Cook pasta al dente',
        'Fry pancetta until crispy',
        'Mix eggs with cheese',
        'Combine all ingredients'
      ],
      avatarImage: 'https://randomuser.me/api/portraits/women/2.jpg',
      userName: 'Jane Smith',
      userEmail: 'jane@example.com',
      portion: '2 servings',
    ),
    Recipe(
      name: 'Beef Burger',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      duration: '25 mins',
      description: 'Juicy homemade beef burger with fresh vegetables',
      ingredients: [
        'Ground beef',
        'Burger buns',
        'Lettuce',
        'Tomato',
        'Cheese'
      ],
      instructions: [
        'Form beef patties',
        'Grill until desired doneness',
        'Toast the buns',
        'Assemble burger with toppings'
      ],
      avatarImage: 'https://randomuser.me/api/portraits/men/3.jpg',
      userName: 'Mike Johnson',
      userEmail: 'mike@example.com',
      portion: '4 servings',
    ),
  ];
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
    ScreenUtil.init(context, designSize: const Size(375, 812));
    
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black, size: 24.sp),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TabBar(
        controller: _tabController,
        labelColor: TColors.primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: TColors.primary,
        labelStyle: TextStyle(fontSize: 14.sp),
        unselectedLabelStyle: TextStyle(fontSize: 14.sp),
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
      padding: EdgeInsets.all(20.w),
      child: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              recipeCard(context, recipes[index]),
              SizedBox(height: 10.h)
            ],
          );
        },
      ),
    );
  }

  Widget buildUserProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const NetworkImage(
                    "https://randomuser.me/api/portraits/men/3.jpg"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '3',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '100',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Followers',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '30',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: TColors.primary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'No bio',
            style: TTextStyles.subtitle.copyWith(
                color: TColors.darkerGrey, 
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          CustomButton(buttonText: "Edit Profile", onPressed: () {}),
        ],
      ),
    );
  }
}
