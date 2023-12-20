// ... (other imports)
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../model/book_order.dart';
import '../model/employee1.dart';
import '../util/constants.dart';
import 'alert_button.dart';

class BookingItemCard extends StatefulWidget {
  final BookingModel bookingitems;

  BookingItemCard({required this.bookingitems});

  @override
  State<BookingItemCard> createState() => _BookingItemCardState();
}

class _BookingItemCardState extends State<BookingItemCard> {
  Future<Employee1>? employee;
  bool isExpanded = false;
  String? formattedDate;

  Future<void> loadData() async {
    employee = homeServices.getEmployeeData(widget.bookingitems.employeeId);
    formattedDate =
        DateFormat('yyyy-MM-dd').format(widget.bookingitems.selectedDay);
  }

  @override
  void initState() {
    loadData();
    print(widget.bookingitems.selectedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: FutureBuilder<Employee1?>(
        future: employee,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('Employee not found');
          } else {
            Employee1 employee = snapshot.data!;
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: isExpanded ? 42.h : 18.h,
              margin: EdgeInsets.fromLTRB(1.5.w, 1.5.w, 1.5.w, 0),
              padding: EdgeInsets.fromLTRB(4.w, 4.w, 4.w, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20.w,
                            width: 20.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                employee.url,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    employee.categorytext,
                                    style: kBold12,
                                  ),
                                  Text(
                                    employee.fullName,
                                    style: kRegular12,
                                  ),
                                  SizedBox(
                                    height: 1.w,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(2.w, 1.w, 2.w, 1.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.w),
                                      color: widget.bookingitems.status ==
                                              'Хүлээгдэж буй'
                                          ? Colors.blue
                                          : widget.bookingitems.status ==
                                                  'Баталгаажсан'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    child: widget.bookingitems.status ==
                                            'Хүлээгдэж буй'
                                        ? Text(
                                            'Хүлээгдэж буй',
                                            style: kMediumWhite10,
                                          )
                                        : widget.bookingitems.status ==
                                                'Баталгаажсан'
                                            ? Text(
                                                'Баталгаажсан',
                                                style: kMediumWhite10,
                                              )
                                            : Text(
                                                'Цуцалсан',
                                                style: kMediumWhite10,
                                              ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            margin: EdgeInsets.only(top: 3.w),
                            padding: EdgeInsets.all(3.w),
                            child: Icon(
                              FontAwesomeIcons.commentDots,
                              color: kPrimaryColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Divider(
                        thickness: 1.sp,
                        color: kTextFieldColor,
                      ),
                      if (isExpanded == false)
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 15.sp,
                        ),
                    ],
                  ),
                  if (isExpanded)
                    Expanded(
                      child: Column(
                        children: [
                          rows('Ангилал', employee.category),
                          rows('Ажилчин', employee.fullName),
                          rows('Хуваарь',
                              '${formattedDate} | ${(widget.bookingitems.startTime)}'),
                          rows('Ажлын цаг',
                              '${widget.bookingitems.quantity.toString()} цаг'),
                          rows('Хаяг', widget.bookingitems.address),
                          rows(
                            'Төлбөр',
                            (employee.salary * widget.bookingitems.quantity)
                                .toString(),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AlertTextButton(
                                text: 'Буцах',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              AlertTextButton(
                                  text: 'Цуцлах',
                                  onPressed: () =>
                                      showCancelBookingDialog(context)),
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Row rows(String type, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: kRegular10,
        ),
        Text(
          data,
          style: kBold10,
        ),
      ],
    );
  }

  void showCancelBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            'Цуцлах',
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Та захиалгыг цуцлахдаа итгэлтэй байна уу!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AlertTextButton(
                    text: 'Буцах',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  AlertTextButton(
                    text: 'Тийм',
                    onPressed: () async {
                      try {
                        var bookingDoc = firestore
                            .collection('users')
                            .doc(widget.bookingitems.userId)
                            .collection('bookings')
                            .doc(widget.bookingitems.bookingId);

                        var docSnapshot = await bookingDoc.get();

                        if (docSnapshot.exists &&
                            docSnapshot.data()?['status'] == 'Цуцалсан') {
                          await bookingDoc.delete();
                        } else {
                          await bookingDoc.update({'status': 'Цуцалсан'});
                        }

                        Navigator.of(context).pop();
                        setState(() {
                          loadData();
                        });
                      } catch (error) {
                        print(error);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
