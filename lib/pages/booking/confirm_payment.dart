import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/pages/booking/pin.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';

import '../../widgets/custom_text_button.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final Employee1 employee;
  final String employeeId;
  final int payment;
  final int selectedTime;
  final String address;
  final int workHour;
  final String selectedDay;
  const ConfirmPaymentScreen(
      {super.key,
      required this.employee,
      required this.employeeId,
      required this.payment,
      required this.address,
      required this.selectedTime,
      required this.workHour,
      required this.selectedDay});

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Баталгаажуулалт',
          center: false,
        ),
        body: Container(
          height: 85.h,
          padding: EdgeInsets.fromLTRB(5.w, 10.w, 5.w, 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                        boxShadow: kBoxShadow,
                        borderRadius: BorderRadius.circular(5.w),
                        color: kScaffoldColor),
                    child: Column(
                      children: [
                        rows('Үйлчилгээ', widget.employee.categorytext),
                        rows('Ангилал', widget.employee.category),
                        rows('Ажилчин', widget.employee.fullName),
                        rows('Хуваарь',
                            '${widget.selectedDay} | ${_getWorkHour(widget.selectedTime)}'),
                        rows('Ажлын цаг', '${widget.workHour.toString()} цаг'),
                        rows('Хаяг', widget.address),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                        boxShadow: kBoxShadow,
                        borderRadius: BorderRadius.circular(5.w),
                        color: kScaffoldColor),
                    child: Column(
                      children: [
                        rows(widget.employee.categorytext,
                            '₮ ${widget.employee.salary * widget.workHour}'),
                        Divider(
                          thickness: 1.sp,
                          color: kHintTextColor,
                        ),
                        rows('Нийт',
                            '₮ ${widget.employee.salary * widget.workHour}'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                        boxShadow: kBoxShadow,
                        borderRadius: BorderRadius.circular(5.w),
                        color: kScaffoldColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              _getImage(widget.payment),
                              height: 20.w,
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              _getName(widget.payment),
                              style: kBold14,
                            )
                          ],
                        ),
                        Text(
                          'Өөрчлөх',
                          style: kMediumBlue12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextButton(
                text: "Үргэлжлүүлэх",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PinCodeScreen(
                        employeeId: widget.employeeId,
                        selectedTime: _getName(widget.selectedTime),
                        selectedDay: widget.selectedDay,
                        address: widget.address,
                        workHour: widget.workHour,
                        payment: _getName(widget.payment),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row rows(String type, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: kRegular12,
        ),
        Text(
          data,
          style: kSemibold14,
        ),
      ],
    );
  }

  String _getWorkHour(int index) {
    switch (index) {
      case 0:
        return '9:00';
      case 1:
        return '10:00';
      case 2:
        return '11:00';
      case 3:
        return '12:00';
      case 4:
        return '13:00';
      case 5:
        return '14:00';
      case 6:
        return '15:00';
      case 7:
        return '16:00';
      case 8:
        return '17:00';
      case 9:
        return '18:00';
      case 10:
        return '19:00';
      default:
        return 'Select the fucking method';
    }
  }

  String _getImage(int paymentMethod) {
    switch (paymentMethod) {
      case 0:
        return 'assets/images/fb_logo.png';
      case 1:
        return 'Haan bank';
      case 2:
        return 'cash';
      case 3:
        return 'body';
      default:
        return 'Select the fucking method';
    }
  }

  String _getName(int paymentMethod) {
    switch (paymentMethod) {
      case 0:
        return 'fb haha';
      case 1:
        return 'Haan bank';
      case 2:
        return 'cash';
      case 3:
        return 'body';
      default:
        return 'Select the fucking method';
    }
  }
}
