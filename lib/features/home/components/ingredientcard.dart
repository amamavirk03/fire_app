import 'package:fire_app/common/styles/text_style.dart';
import 'package:fire_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageText extends StatefulWidget {
  final String imagePath;
  final String text;

  const ImageText({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  _ImageTextState createState() => _ImageTextState();
}

class _ImageTextState extends State<ImageText> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.sp, vertical: 4.sp),
        decoration: BoxDecoration(
          border: Border.all(color: TColors.primary),
          borderRadius: BorderRadius.circular(20.r),
          color: _isSelected ? TColors.primary : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(4.sp),
              child: Image.asset(
                widget.imagePath,
                width: 25.w,
                height: 25.h,
              ),
            ),
            Expanded(
              child: Text(
                widget.text,
                style: TTextStyles.subtitle.copyWith(
                  color: _isSelected ? Colors.white : TColors.darkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
