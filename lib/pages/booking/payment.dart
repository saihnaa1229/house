import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/pages/booking/confirm_payment.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../../model/employee1.dart';
import '../../widgets/choose_box.dart';

class PaymentScreen extends StatefulWidget {
  final Employee1 employee;
  final String employeeId;
  final int selectedTime;
  final String address;
  final int workHour;
  final String selectedDay;
  const PaymentScreen(
      {super.key,
      required this.selectedDay,
      required this.employee,
      required this.employeeId,
      required this.address,
      required this.selectedTime,
      required this.workHour});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedChoiceIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadIcon: Icon(Icons.arrow_back_rounded),
          title: 'Төлбөрийн төрөл',
        ),
        body: Container(
          padding: EdgeInsets.all(5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Төлбөр төлөх төрлөө сонгоно уу',
                    style: kBold14,
                  ),
                  Container(
                    height: 63.h,
                    child: ListView(
                      children: [
                        ImageChoiceBox(
                          imagePath: 'assets/images/fb_logo.png',
                          text: 'Social pay',
                          isSelected: selectedChoiceIndex == 0,
                          onTap: () {
                            setState(() {
                              selectedChoiceIndex = 0;
                            });
                          },
                        ),
                        ImageChoiceBox(
                          imagePath: 'assets/images/fb_logo.png',
                          text: 'Haan bank',
                          isSelected: selectedChoiceIndex == 1,
                          onTap: () {
                            setState(() {
                              selectedChoiceIndex = 1;
                            });
                          },
                        ),
                        ImageChoiceBox(
                          imagePath: 'assets/images/fb_logo.png',
                          text: 'Cash',
                          isSelected: selectedChoiceIndex == 2,
                          onTap: () {
                            setState(() {
                              selectedChoiceIndex = 2;
                            });
                          },
                        ),
                        ImageChoiceBox(
                          imagePath: 'assets/images/fb_logo.png',
                          text: 'Body',
                          isSelected: selectedChoiceIndex == 3,
                          onTap: () {
                            setState(() {
                              selectedChoiceIndex = 3;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextButton(
                  text: 'Үргэлжлүүлэх',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmPaymentScreen(
                                payment: selectedChoiceIndex,
                                employee: widget.employee,
                                employeeId: widget.employeeId,
                                selectedTime: widget.selectedTime,
                                address: widget.address,
                                workHour: widget.workHour,
                                selectedDay: widget.selectedDay,
                              )),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
