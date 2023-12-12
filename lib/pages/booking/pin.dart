// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/util/user.dart';
import 'package:test_fire/util/utils.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../../model/book_order.dart';

class PinCodeScreen extends StatefulWidget {
  final String employeeId;
  final String selectedTime;
  final String selectedDay;
  final String address;
  final int workHour;
  final String payment;
  const PinCodeScreen(
      {super.key,
      required this.address,
      required this.employeeId,
      required this.payment,
      required this.selectedDay,
      required this.selectedTime,
      required this.workHour});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  String pin = '';
  String? userId = UserPreferences.getUser();

  void _onKeypadTap(String value) {
    setState(() {
      if (value == 'delete') {
        if (pin.isNotEmpty) {
          pin = pin.substring(0, pin.length - 1);
        }
      } else {
        if (pin.length < 4) {
          pin += value;
          if (pin.length == 4) {
            _verifyPin();
          }
        }
      }
    });
  }

  void _verifyPin() async {
    if (pin.length == 4) {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(userId).get();
      String userPin = userDoc['pin'];
      if (pin == userPin) {
        print('PIN is correct!');
        _createBooking();
        _showSuccessDialog();
      } else {
        Utils.showSnackBar('Пин код буруу байна.');
        setState(
          () {
            pin = '';
          },
        );
      }
    }
  }

  Widget _pinIndicator(int index) {
    bool hasValue = pin.length > index;
    Color borderColor = kTextFieldColor;
    Color fillColor = hasValue ? borderColor : borderColor;

    if (!hasValue && index == pin.length) {
      fillColor = Theme.of(context).primaryColor;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 3.w, 5.w, 3.w),
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border.all(color: fillColor, width: 1.sp),
        borderRadius: BorderRadius.circular(4.w),
        color: borderColor,
      ),
      child: Container(
        width: 5.w,
        height: 5.w,
        decoration: BoxDecoration(
          color: hasValue ? Colors.black : borderColor,
          shape: BoxShape.circle,
          // border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, {String? label}) {
    return InkWell(
      onTap: () => _onKeypadTap(number),
      borderRadius: BorderRadius.circular(48.0),
      child: Container(
        alignment: Alignment.center,
        height: 20.w,
        width: 25.w,
        child: Text(
          label ?? number,
          style: kbold24,
        ),
      ),
    );
  }

  void _createBooking() async {
    String bookingStatus = 'Хүлээгдэж буй';

    BookingModel newBooking = BookingModel(
      userId: userId ?? '',
      employeeId: widget.employeeId,
      selectedDay: DateTime.parse(widget.selectedDay),
      timeSlot: widget.selectedTime,
      quantity: widget.workHour,
      address: widget.address,
      status: bookingStatus,
      bookingId: '',
    );

    DocumentReference statusRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('bookings')
        .doc(bookingStatus);

    DocumentReference bookingDetailRef = statusRef.collection('bookings').doc();

    await bookingDetailRef.set(newBooking.toMap()).then((_) {
      print('Booking detail created with ID: ${bookingDetailRef.id}');
      statusRef.update({'bookingId': bookingDetailRef.id});
      _showSuccessDialog();
    }).catchError((error) {
      print('Error creating booking detail: $error');
      Utils.showSnackBar('Алдаа гарлаа: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your PIN'),
        leading: BackButton(),
      ),
      body: Container(
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Text(
              'Enter your PIN to confirm payment',
              style: kBold14,
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++) _pinIndicator(i),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['1', '2', '3']
                        .map((number) => _buildNumberButton(number))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['4', '5', '6']
                        .map((number) => _buildNumberButton(number))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['7', '8', '9']
                        .map((number) => _buildNumberButton(number))
                        .toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNumberButton('*', label: '*'),
                      _buildNumberButton('0'),
                      _buildNumberButton('delete', label: '⌫'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  // backgroundColor: kPrimaryColor,
                  radius: 10.h,
                  child: Image.asset('assets/images/success.gif'),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Booking Successful!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'You have successfully made payment and booked the services.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                CustomTextButton(
                    text: 'Амжилттай',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
