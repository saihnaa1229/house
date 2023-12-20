// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/calendar_screen.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';

import '../../pages/admin/admin_profile_scree.dart';
import '../../pages/booking_screen.dart';
import '../../pages/employee/employee_profile_screen.dart';
import '../../pages/user_profile_screen.dart';
import '../../util/constants.dart';
import '../../util/user.dart';
import 'bottom_navigation.dart';
import 'bottom_navigation_item.dart';

class BottomNavigationContainer extends StatefulWidget {
  final int bottomBarIndex;
  const BottomNavigationContainer({super.key, required this.bottomBarIndex});

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  String? userRole = UserPreferences.getUserRole();
  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      activeColor: kPrimaryColor,
      index: widget.bottomBarIndex,
      children: [
        BottomNavigationItem(
            iconText: 'Нүүр',
            icon: Icon(Icons.storefront),
            iconSize: 22.sp,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
        BottomNavigationItem(
          iconText: 'Захиалга',
          icon: Icon(Icons.manage_search_rounded),
          iconSize: 22.sp,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookingScreen()));
          },
        ),
        BottomNavigationItem(
          iconText: 'Календарь',
          icon: Icon(Icons.shopping_cart_outlined),
          iconSize: 22.sp,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarScreen()),
            );
          },
        ),
        BottomNavigationItem(
          iconText: 'Мэдэгдэл',
          icon: Icon(Icons.favorite_border_rounded),
          iconSize: 22.sp,
          onPressed: () async {
            // homeServices.addEmployee();
            homeServices.employeesByCategory();
            print('done');
          },
        ),
        BottomNavigationItem(
          iconText: 'Профайл',
          icon: Icon(Icons.account_circle_outlined),
          iconSize: 22.sp,
          onPressed: () {
            switch (userRole) {
              case 'admin':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminProfileScreen()),
                );
                break;
              case 'employee':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeProfileScreen()),
                );
                break;
              case 'user':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen()),
                );
                break;
            }
          },
        ),
      ],
    );
  }
}
