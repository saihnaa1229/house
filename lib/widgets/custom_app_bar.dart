import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? widget;
  final Icon? leadIcon;
  final Icon? actionIcon;
  final String? title;
  final Color? bgColor;

  CustomAppBar(
      {this.actionIcon, this.leadIcon, this.title, this.bgColor, this.widget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor,
      leading: leadIcon == null
          ? null
          : IconButton(
              icon: leadIcon!,
              iconSize: 20.0.sp,
              color: kIconColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      actions: actionIcon != null
          ? [
              IconButton(
                iconSize: 15.0.sp,
                color: kIconColor,
                icon: actionIcon!,
                onPressed: () {},
              )
            ]
          : null,
      title: title != null
          ? Text(
              title!,
              style: kSemibold18,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.h);
}
