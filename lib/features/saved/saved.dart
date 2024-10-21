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
    await Future.delayed(
        const Duration(seconds: 2));
    return [
      {
        'postID': '1',
        'postDetails': {
          'title': 'Delicious Pasta',
          'image': 'assets/images/pasta.jpg',
          'views': '150'
        }
      },
      {
        'postID': '2',
        'postDetails': {
          'title': 'Healthy Salad',
          'image': 'assets/images/salad.jpg',
          'views': '200'
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
        title: const Center(child: Text("Recipe Saved",)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getSavedPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 5.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data![index];
                  return InkWell(
                    child: SavePostCard(
                      postID: post['postID'],
                      postDetails: post['postDetails'],
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.recipepage);
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("No saved posts yet."));
            }
          },
        ),
      ),
    );
  }
}
