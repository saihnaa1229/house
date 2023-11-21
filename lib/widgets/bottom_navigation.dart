// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';
import 'bottom_navigation_item.dart';

class BottomNavigation extends StatelessWidget {
  final List<BottomNavigationItem> children;
  final int index;
  final Color activeColor;

  BottomNavigation({
    required this.children,
    required this.index,
    required this.activeColor,
  }) {
    children[index].color = activeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kScaffoldColor,
      ),
      height: 11.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}
