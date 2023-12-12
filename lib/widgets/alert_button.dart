import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';
import 'custom_text_button.dart';

class AlertTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  // final int width;

  const AlertTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    // required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w), color: kPrimaryColor),
      child: CustomTextButton(
        onPressed: () {
          onPressed();
        },
        text: text,
      ),
    );
  }
}
