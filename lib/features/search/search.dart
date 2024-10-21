import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/home/components/searchbar.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:fire_app/utils/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: const Center(child: Text("Search Page")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Searchbarr(),
              SizedBox(
                height: 10.h,
              ),
              customTextRow(firstText: 'Search History', secondText: 'See all'),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 400.h,
                child: ListView(
                  children: List.generate(
                    4,
                    (index) => Column(
                      children: [
                        customImageTextRow(),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Function to create a custom row with two text widgets
  Widget customTextRow({
    required String firstText,
    required String secondText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: TTextStyles.heading.copyWith(fontSize: 20.sp),
        ),
        Text(
          secondText,
          style: TTextStyles.subtitle
              .copyWith(fontSize: 18.sp, color: TColors.primary),
        ),
      ],
    );
  }
}

Widget customImageTextRow() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage(TImages.food1),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fried Noodles",
            style: TTextStyles.heading,
          ),
          const SizedBox(height: 4),
          Text(
            "4 days",
            style: TTextStyles.subtitle.copyWith(color: TColors.darkGrey),
          ),
        ],
      ),
    ],
  );
}
