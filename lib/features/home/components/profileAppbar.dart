import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/routes/routename.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreenAppbar extends StatefulWidget {
  const HomeScreenAppbar({super.key});

  @override
  State<HomeScreenAppbar> createState() => _HomeScreenAppbarState();
}

class _HomeScreenAppbarState extends State<HomeScreenAppbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: TColors.grey,
            backgroundImage: const NetworkImage(
                "https://randomuser.me/api/portraits/men/1.jpg"),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Savannah Nguyen",
                style: TTextStyles.heading
                    .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: TColors.primary, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    "South Dakota 83475",
                    style: TTextStyles.subtitle
                        .copyWith(fontSize: 14.sp, color: TColors.darkGrey),
                  ),
                  Icon(Icons.arrow_drop_down, size: 16.sp),
                ],
              )
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.notification);
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Icon(Icons.notifications,
                        size: 20.sp, color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
