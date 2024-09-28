import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final Color? backgroundColor; // Custom background color
  final Color? textColor; // Custom text color

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.backgroundColor, // Optional background color
    this.textColor, // Optional text color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: 45.h,
        decoration: BoxDecoration(
          color:
              backgroundColor ?? TColors.primary, // Use custom or default color
          borderRadius: BorderRadius.circular(30.sp),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TTextStyles.buttonText.copyWith(
              color:
                  textColor ?? Colors.white, // Use custom or default text color
            ),
          ),
        ),
      ),
    );
  }
}
