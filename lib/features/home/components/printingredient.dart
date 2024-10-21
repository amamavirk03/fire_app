import 'package:fire_app/features/home/components/ingredientcard.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Printingredient extends StatelessWidget {
  final List<String> imagePaths = [
    TImages.broccoli,
    TImages.egg,
    TImages.chicken,
    TImages.meat,
    TImages.shimp,
    TImages.tomato,
    TImages.broccoli,
  ];

  final List<String> texts = [
    "Broccoli",
    "Egg",
    "Chicken",
    "Meat",
    "Shrimp",
    "Tomato",
    "Broccoli"
  ];

  Printingredient({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 16.sp),
      child: SizedBox(
        height: 400.h, // Set a fixed height for the GridView
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.sp,
            mainAxisSpacing: 10.sp,
          ),
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return ImageText(
              imagePath: imagePaths[index % imagePaths.length],
              text: texts[index],
            );
          },
        ),
      ),
    );
  }
}
