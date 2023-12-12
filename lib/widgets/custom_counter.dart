import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class CustomCounter extends StatefulWidget {
  final CounterChangedCallback onCounterChanged;
  final int? quantity;

  const CustomCounter({
    super.key,
    required this.quantity,
    required this.onCounterChanged,
  });

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.quantity == null ? _counter = 0 : _counter = widget.quantity!;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.onCounterChanged(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        widget.onCounterChanged(_counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.h, top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5.h,
            width: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: kPrimaryColor.withOpacity(0.2),
            ),
            child: IconButton(
              onPressed: _decrementCounter,
              icon: const Icon(
                FontAwesomeIcons.minus,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            // height: 6.h,
            width: 10.w,
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
            ),
            child: Text(
              '$_counter',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: 5.h,
            width: 5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: kPrimaryColor.withOpacity(0.2),
            ),
            child: IconButton(
              onPressed: _incrementCounter,
              icon: const Icon(
                FontAwesomeIcons.plus,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
