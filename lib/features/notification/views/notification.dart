import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/features/notification/components/notificationwidget.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import GetX for arguments

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var notificationData;

  @override
  void initState() {
    super.initState();
    notificationData = Get.arguments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(), // Navigate back on tap
        ),
        title: const Text("Notifications"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
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
              child: notificationData.isNotEmpty
                  ? ListView.builder(
                      itemCount: notificationData.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notification: notificationData[index],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No Notifications Available",
                        style: TTextStyles.heading.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
