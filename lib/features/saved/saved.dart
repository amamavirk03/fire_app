import 'package:fire_app/features/home/components/searchbar.dart';
import 'package:fire_app/features/saved/components/savepost.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({
    super.key,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TColors.white,
        appBar: AppBar(
          backgroundColor: TColors.white,
          title: const Center(child: Text("Recipe Saved")),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Searchbarr(),
                SizedBox(
                  height: 20.h,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 1500.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 5.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemCount: 4, // Adjust the number of items as needed
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: const SavePostCard(),
                          onTap: () {
                            Get.toNamed(AppRoutes.recipepage);
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
