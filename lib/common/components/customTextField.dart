import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String fieldName;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  final bool? obscureText;
  final String? errorText;
  final int? maxLines;
  final double? width; // Optional width property

  const CustomTextField({
    this.errorText,
    super.key,
    required this.fieldName,
    required this.inputType,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.maxLines, // Optional, so not required in constructor
    this.width, required String? Function(dynamic value) validator, // Optional width, default to double.infinity
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: TTextStyles.heading.copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          alignment: Alignment.center,
          width: width ??
              double.infinity, // Use width if provided, else double.infinity
          height: maxLines == null || maxLines == 1
              ? 55.h // Default height for single-line text field
              : null, // Flexible height if multiline
          decoration: BoxDecoration(
            color: TColors.textfield,
            borderRadius: BorderRadius.circular(30.sp),
          ),
          child: TextField(
            obscureText: obscureText ?? false,
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines ?? 1, // Default to 1 line if maxLines is null
            style: TTextStyles.subtitle.copyWith(
              color: TColors.black,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              hintStyle: TTextStyles.subtitle.copyWith(
                color: TColors.textSecondary,
              ),
              contentPadding: const EdgeInsets.all(
                  8.0), // Set contentPadding to zero or adjust as needed
              isDense: true, // Makes the input field compact if needed
              border: InputBorder.none, // No visible border
            ),
          ),
        ),
      ],
    );
  }
}
