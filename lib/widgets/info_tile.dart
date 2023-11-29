import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoTile extends StatelessWidget {
  String title;
  String info;
  InfoTile({super.key, required this.info, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 8,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        info,
        style: TextStyle(
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
