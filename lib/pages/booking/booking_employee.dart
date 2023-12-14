// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/pages/booking/payment.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/util/user.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_counter.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:test_fire/widgets/custom_textfield.dart';

class BookingEmployeeScreen extends StatefulWidget {
  final String employeeId;
  final Employee1 employee;
  const BookingEmployeeScreen(
      {super.key, required this.employeeId, required this.employee});

  @override
  State<BookingEmployeeScreen> createState() => _BookingEmployeeScreenState();
}

class _BookingEmployeeScreenState extends State<BookingEmployeeScreen> {
  TextEditingController _address = TextEditingController();
  int _quantity = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedChipIndex = 0;
  List<String> _categories = [
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadIcon: Icon(Icons.arrow_back_rounded),
          title: 'Захиалгын дэлгэрнгүй',
          center: false,
          actionIcon: Icon(Icons.search),
          bgColor: kScaffoldColor,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 75.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Захиалгын өдөр сонгох',
                          style: kBold14,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(
                              3.w), // You can adjust the padding as needed
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust for rounded corners
                          ),

                          child: TableCalendar(
                            rowHeight: 10.w,
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2024, 12, 31),
                            focusedDay: _focusedDay,
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              if (selectedDay.isAfter(DateTime.now())) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              }
                            },
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
                                  DateTime.now().subtract(Duration(days: 1)));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(6.w, 3.w, 0.w, 3.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: kBoxShadow,
                            borderRadius: BorderRadius.circular(5.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ажиллах цаг',
                                style: kBold12,
                              ),
                              CustomCounter(
                                quantity: _quantity,
                                onCounterChanged: (quantity) {
                                  _quantity = quantity;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Захиалгын цаг сонгох',
                          style: kBold14,
                        ),
                        Container(
                          height: 8.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: ChoiceChip(
                                  label: Row(
                                    children: [
                                      Text(
                                        _categories[index],
                                        style: kRegular12,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text('AM'),
                                    ],
                                  ),
                                  selected: _selectedChipIndex == index,
                                  selectedColor: kPrimaryColor,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedChipIndex = selected ? index : 0;
                                    });
                                  },
                                  labelStyle: TextStyle(
                                    color: _selectedChipIndex == index
                                        ? Colors.white
                                        : kPrimaryColor,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          width: 2.sp, color: kPrimaryColor)),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Үйлчилгээ авах хаяг',
                          style: kBold14,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomTextField(
                          hintText: 'Хаяг оруулах',
                          icon: false,
                          controller: _address,
                          obScure: false,
                          leadIcon: (Icons.house_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTextButton(
                    text: 'Үргэлжлүүлэх',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  employee: widget.employee,
                                  employeeId: widget.employeeId,
                                  selectedTime: _selectedChipIndex,
                                  selectedDay: formatSelectedDay(_selectedDay),
                                  address: _address.text,
                                  workHour: _quantity,
                                )),
                      );
                      print(widget.employeeId);
                      print(
                        _selectedChipIndex,
                      );
                      print(_selectedDay);
                      print(_address.text);
                      print(_quantity);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatSelectedDay(DateTime? selectedDay) {
    if (selectedDay == null) {
      return 'No date selected';
    } else {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(selectedDay);
    }
  }
}
