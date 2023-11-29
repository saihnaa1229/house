import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String hintText;
  final bool icon;
  final IconData? leadIcon;
  final TextEditingController controller;
  final bool? inputType;
  bool obScure;
  final FocusNode focusNode = FocusNode();
  bool isFieldActive = false;

  CustomTextField(
      {required this.hintText,
      required this.icon,
      this.inputType,
      this.label,
      required this.controller,
      required this.obScure,
      required this.leadIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    widget.focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      widget.isFieldActive = widget.focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.leadIcon != null
          ? EdgeInsets.all(2.w)
          : EdgeInsets.fromLTRB(6.w, 2.w, 2.w, 2.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.sp,
          color: widget.isFieldActive
              ? Color.fromARGB(255, 72, 5, 255)
              : kScaffoldColor,
        ),
        borderRadius: BorderRadius.circular(5.w),
        color: widget.isFieldActive ? Colors.blue : kTextFieldColor,
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.inputType != true
            ? TextInputType.emailAddress
            : TextInputType.phone,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: widget.leadIcon != null
              ? Icon(
                  widget.leadIcon,
                  color: widget.isFieldActive
                      ? Color.fromARGB(255, 72, 5, 255)
                      : kHintTextColor,
                )
              : null,
          suffixIcon: widget.icon == true
              ? IconButton(
                  icon: widget.obScure
                      ? Icon(
                          Icons.visibility_off,
                          color: widget.isFieldActive
                              ? Color.fromARGB(255, 72, 5, 255)
                              : kHintTextColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: widget.isFieldActive
                              ? Color.fromARGB(255, 72, 5, 255)
                              : kHintTextColor,
                        ),
                  onPressed: () {
                    setState(() {
                      widget.obScure = !widget.obScure;
                    });
                  },
                )
              : null,
        ),
        obscureText: widget.obScure == true ? true : false,
      ),
    );
  }
}
