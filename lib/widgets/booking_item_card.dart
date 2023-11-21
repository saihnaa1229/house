import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/booking.dart';

import '../util/constants.dart';

class BookingItemCard extends StatelessWidget {
  final Booking bookingitems;

  BookingItemCard({required this.bookingitems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(4.w),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 25.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                bookingitems.employee.img,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookingitems.employee.category,
                      style: kSemibold14,
                    ),
                    SizedBox(
                      height: 3.w,
                    ),
                    Text(
                      bookingitems.employee.name,
                      style: kRegular12,
                    ),
                    SizedBox(
                      height: 3.w,
                    ),
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: bookingitems.status == 2
                            ? Colors.red
                            : bookingitems.status == 1
                                ? Colors.green
                                : Colors.blue,
                      ),
                      child: bookingitems.status == 0
                          ? Text(
                              'Up Coming',
                              style: kMediumWhite10,
                            )
                          : bookingitems.status == 1
                              ? Text(
                                  'Completed',
                                  style: kMediumWhite10,
                                )
                              : Text(
                                  'Canceled',
                                  style: kMediumWhite10,
                                ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5.w)),
                margin: EdgeInsets.only(top: 6.w),
                padding: EdgeInsets.all(3.w),
                child: Icon(
                  FontAwesomeIcons.commentDots,
                  color: kPrimaryColor,
                  size: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
