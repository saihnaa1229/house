import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomTextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 3.h),
      height: 7.h,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.w),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: kButtonTextStyle,
        ),
      ),
    );
  }
}
