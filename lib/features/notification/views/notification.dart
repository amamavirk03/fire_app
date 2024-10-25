import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notificationData = [
    {
      'type': 'like',
      'title': 'John Doe liked your recipe',
      'description': 'Your Chocolate Cake recipe got a new like',
      'time': '2 mins ago',
      'image': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'type': 'comment',
      'title': 'Sarah commented on your post',
      'description': 'Great recipe! I tried it yesterday...',
      'time': '15 mins ago',
      'image': 'https://randomuser.me/api/portraits/women/2.jpg',
    },
    {
      'type': 'follow',
      'title': 'Mike started following you',
      'description': 'You have a new follower',
      'time': '1 hour ago',
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
    {
      'type': 'mention',
      'title': 'Emma mentioned you in a comment',
      'description': '@cookmaster your version looks amazing!',
      'time': '2 hours ago',
      'image': 'https://randomuser.me/api/portraits/women/4.jpg',
    },
    {
      'type': 'save',
      'title': 'Your recipe is trending!',
      'description': 'Your Pasta Recipe has been saved 100 times',
      'time': '3 hours ago',
      'image': 'https://picsum.photos/200/300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true, splitScreenMode: true);
    
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text("Notifications", style: TextStyle(fontSize: 16.sp)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth > 600 ? 600 : maxWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "Your Notifications",
                      style: TTextStyles.heading.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: notificationData.length,
                        itemBuilder: (context, index) {
                          final notification = notificationData[index];
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                              leading: CircleAvatar(
                                radius: 20.r,
                                backgroundImage: NetworkImage(notification['image']),
                              ),
                              title: Text(
                                notification['title'],
                                style: TTextStyles.heading.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                notification['description'],
                                style: TTextStyles.heading.copyWith(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Text(
                                notification['time'],
                                style: TTextStyles.heading.copyWith(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}