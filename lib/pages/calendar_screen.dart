import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_fire/widgets/bottomNavigationBar/custom_bottom_navigation.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';

import '../util/constants.dart';
import '../util/user.dart';
import '../widgets/booking_item_card.dart';
import '../widgets/booking_item_card_container.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Future<List<BookingItemCard>>? _bookings;
  int bottomBarIndex = 2;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? userId = UserPreferences.getUser();
  String? formattedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Календарь',
          center: false,
          leadIcon: Icon(Icons.arrow_back_rounded),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TableCalendar(
                  rowHeight: 10.w,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2024, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: onDaySelectedCallback,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.black),
                    disabledTextStyle: TextStyle(color: Colors.black),
                    selectedDecoration: BoxDecoration(
                      color: kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.5),
                        shape: BoxShape.circle),
                    outsideDaysVisible: false,
                  ),
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: kBold14),
                  enabledDayPredicate: (day) {
                    return day.isAfter(
                      DateTime.now().subtract(
                        Duration(days: 1),
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder<List<BookingItemCard>>(
                future: _bookings,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<BookingItemCard> _bookings = snapshot.data!;
                    return Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Захиалгууд',
                              style: kBold14,
                            ),
                            Text(
                              ' (${_bookings.length.toString()})',
                              style: kBold14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SingleChildScrollView(
                          // child: EmployeeContainer(
                          //   employee: _employees,
                          // ),
                          child: BookingItemCardContainer(
                            bookingItem: _bookings,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("No products found");
                  }
                },
              ),
            ]),
          ),
        ),
        bottomNavigationBar:
            BottomNavigationContainer(bottomBarIndex: bottomBarIndex),
      ),
    );
  }

  void onDaySelectedCallback(DateTime selectedDay, DateTime focusedDay) {
    if (selectedDay.isAfter(DateTime.now())) {
      setState(() {
        // Timestamp selectedTimestamp = Timestamp.fromDate(selectedDay);
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(selectedDay);
        // _bookings = homeServices.getBookingBySelectedDay(selectedDay, userId!);
        _bookings = homeServices.getBookingBySelectedDay(formattedDate!);
        // _bookings = homeServices.getBookingsByStatus('Цуцалсан');
        print(_bookings);
        print(userId);
        print(selectedDay);
        print(formattedDate);
      });
    }
  }
}
