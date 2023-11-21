import 'package:flutter/material.dart';

import '../util/constants.dart';

class BottomNavigationItem extends StatelessWidget {
  final Icon icon;
  final double iconSize;
  final Function? onPressed;
  final String iconText;
  Color? color;

  BottomNavigationItem({
    required this.icon,
    required this.iconSize,
    required this.iconText,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: iconSize,
          color: color ?? kHintTextColor,
          onPressed: () => onPressed!(),
          icon: icon,
        ),
        Text(iconText),
      ],
    );
  }
}
