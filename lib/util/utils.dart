import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Container(
        padding: EdgeInsets.all(5.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
            color: kScaffoldColor,
            border: Border.all(width: 0.5.sp, color: kSearchHintTextColor),
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: kBoxShadow),
        child: Text(
          text,
          style: kMedium14,
        ),
      ),
      backgroundColor: kScaffoldColor,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
