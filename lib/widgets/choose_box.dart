import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';

class ImageChoiceBox extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  ImageChoiceBox({
    required this.imagePath,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(5.w, 1.w, 5.w, 1.w),
        margin: EdgeInsets.symmetric(vertical: 3.w),
        decoration: BoxDecoration(
          color: kScaffoldColor,
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.all(Radius.circular(5.w)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagePath, width: 20.w, height: 20.w),
                SizedBox(width: 5.w),
                Text(text),
              ],
            ),
            isSelected
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    color: kPrimaryColor,
                  )
                : Icon(
                    Icons.circle_outlined,
                    color: kPrimaryColor,
                  )
          ],
        ),
      ),
    );
  }
}
