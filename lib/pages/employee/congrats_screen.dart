import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';

import '../../util/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text_button.dart';

class CongratScreen extends StatelessWidget {
  const CongratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        leadIcon: Icon(Icons.arrow_back_rounded),
        title: 'Бүртгэл дууслаа',
        bgColor: kScaffoldColor,
      ),
      body: Container(
        padding: EdgeInsets.all(5.w),
        margin: EdgeInsets.only(bottom: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/accepted.gif', height: 40.h),
                SizedBox(height: 4.h),
                Text('Амжилттай!', style: kCongratsStyle),
                SizedBox(height: 4.h),
                Text('Ажилтны хаяг ашиглахад бэлэн боллоо', style: kRegular12)
              ],
            ),
            CustomTextButton(
                text: 'Үргэлжлүүлэх',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                })
          ],
        ),
      ),
    ));
  }
}
