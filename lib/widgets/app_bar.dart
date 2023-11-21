import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class AppBarWithImage extends StatefulWidget {
  final IconData? leadIcon;
  final Function? leadIconFuncion;
  final String? img;
  final String? text;
  final IconData? suffixIcon1;
  final IconData? suffixIcon2;
  final Function? suffixIcon1Function;

  final Function? suffixIcon2Function;

  AppBarWithImage({
    this.leadIcon,
    this.img,
    this.suffixIcon1,
    this.suffixIcon2,
    this.text,
    this.leadIconFuncion,
    this.suffixIcon1Function,
    this.suffixIcon2Function,
  });

  @override
  State<AppBarWithImage> createState() => _AppBarWithImageState();
}

class _AppBarWithImageState extends State<AppBarWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.leadIcon == null
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.25),
                        ),
                        child: IconButton(
                          icon: Icon(
                            widget.leadIcon,
                            size: 7.w,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            widget.leadIconFuncion!();
                          },
                        ),
                      ),
                    ),
              widget.img != null
                  ? Image.asset(
                      widget.img!,
                      height: 15.w,
                      width: 15.w,
                    )
                  : SizedBox(),
              SizedBox(
                width: 2.w,
              ),
              widget.text != null
                  ? Text(widget.text!, style: kSemibold16)
                  : SizedBox(),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.suffixIcon1,
                  size: 7.w,
                  color: kHintTextColor,
                ),
                onPressed: () {
                  widget.suffixIcon1Function!();
                },
              ),
              SizedBox(
                width: 3.w,
              ),
              IconButton(
                icon: Icon(
                  widget.suffixIcon2,
                  size: 7.w,
                  color: kHintTextColor,
                ),
                onPressed: () {
                  widget.suffixIcon2Function!();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
