import 'dart:math';

import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
              Tab(text: 'Tab 4'),
              Tab(text: 'Tab 5'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabPage(),
            _buildTabPage(),
            _buildTabPage(),
            _buildTabPage(),
            _buildTabPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPage() {
    // List of predefined text strings
    final List<String> randomTexts = [
      'Fresh Vegetables',
      'Healthy Fruits',
      'Organic Meat',
      'Delicious Seafood',
      'Exotic Spices',
      'Homemade Sauces',
      'Gourmet Cheese',
      'Artisan Breads',
      'Craft Beers',
      'Premium Wines',
    ];

    // Function to get a random text
    String getRandomText() {
      final random = Random();
      return randomTexts[random.nextInt(randomTexts.length)];
    }

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: List.generate(
                10, // Number of cards
                (index) => Container(
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      getRandomText(), // Display random text
                      style: TTextStyles.subtitle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
