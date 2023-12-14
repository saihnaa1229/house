import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _selectedChipIndex = 0;

  List<String> _categories = ['All', '5', '4', '3', '2', '1'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: ChoiceChip(
              label: Row(
                children: [
                  Icon(
                    Icons.star_rate_rounded,
                    color: _selectedChipIndex == index
                        ? Colors.white
                        : kPrimaryColor,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    _categories[index],
                    style: kRegular12,
                  ),
                ],
              ),
              selected: _selectedChipIndex == index,
              selectedColor: kPrimaryColor,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChipIndex = selected ? index : 0;
                });
              },
              labelStyle: TextStyle(
                color:
                    _selectedChipIndex == index ? Colors.white : kPrimaryColor,
              ),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                  side: BorderSide(width: 2.sp, color: kPrimaryColor)),
            ),
          );
        },
      ),
    );
  }
}
