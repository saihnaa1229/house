import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/services/home_service.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final HomeServices homeServices = HomeServices();
typedef CounterChangedCallback = void Function(int newCount);

const kLoginText = 'Нэвтрэх';
const kHomeScreenHintText = "Хайх";
const kSigninText = 'Шинээр бүртгүүлэх';

const kScaffoldColor = Color(0xffFFFFFF);
const kIconColor = Color(0XFF181725);
const kHintTextColor = Color(0xff7C7C7C);
const kTextFieldColor = Color(0xffF2F3F2);
const kSearchHintTextColor = Color(0xff7C7C7C);

const kPrimaryColor = Color(0xff7210FF);

final kHomeScreenHintTextStyle = TextStyle(
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
  color: kSearchHintTextColor,
);

final kSemibold18 = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
);

final kbold18 = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w800,
);

final kbold34 = TextStyle(
  fontSize: 34.sp,
  fontWeight: FontWeight.w800,
);

final kbold24 = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.w800,
);

final kRegular12 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);
final kRegular10 = TextStyle(
  fontSize: 10.sp,
  fontWeight: FontWeight.w300,
);

final kBold10 = TextStyle(
  fontSize: 10.sp,
  fontWeight: FontWeight.w600,
);

final kBold12 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

final kSemibold16 = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
);

final kRegularHint14 = TextStyle(
    fontSize: 16.sp, fontWeight: FontWeight.w400, color: kHintTextColor);

final kSemiboldBlue16 = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);

final kSemibold14 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
);

final kMediumBlue14 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: kPrimaryColor,
);
final kMedium14 = TextStyle(
    fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black);

final kMediumWhite10 = TextStyle(
    fontSize: 10.sp, fontWeight: FontWeight.w400, color: kScaffoldColor);
final kBold14 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
);

final kCongratsStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
);

final kRegularBlue12 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w300,
  color: Colors.blue,
);

final kMediumBlue12 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
  color: Colors.blue,
);

final kHintRegular12 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w300,
  color: kHintTextColor,
);
final kHintRegular10 = TextStyle(
  fontSize: 10.sp,
  fontWeight: FontWeight.w300,
  color: kHintTextColor,
);

final kButtonTextStyle = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.w300,
  color: kScaffoldColor,
);

final kBoxShadow = [
  BoxShadow(
    color: Colors.blue.withOpacity(0.1), // Shadow color with some transparency
    spreadRadius: 5, // Extend the shadow to all sides by 1 unit
    blurRadius: 7, // Blur radius for the shadow
    offset: const Offset(0, 3), // Position of the shadow
  ),
];
