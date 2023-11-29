// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';

import '../model/employee1.dart';
import '../util/constants.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/bottom_navigation_item.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/info_tile.dart';
import 'auth/log_in_screen.dart';
import 'booking_screen.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  int bottomBarIndex = 4;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Employee1>(
          future: homeServices.getEmployeeData(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${userId}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Employee not found'));
            }

            Employee1 employee = snapshot.data!;

            return Container(
              padding: EdgeInsets.all(5.w),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundImage: NetworkImage(employee.url),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 24),
                    Text(
                      employee.fullName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24),
                    InfoTile(title: 'Цахим шуудан', info: employee.email),
                    InfoTile(
                        title: 'Утасны дугаар', info: employee.phoneNumber),
                    InfoTile(title: 'Хаяг', info: employee.address),
                    InfoTile(title: 'Ангилал', info: employee.category),
                    InfoTile(title: 'Цалин', info: '\$${employee.salary}'),
                    InfoTile(title: 'Үнэлгээ', info: '${employee.rating}/5'),
                    CustomTextButton(
                      onPressed: () {
                        // Sign out the user when the button is pressed
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      text: "Гарах",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigation(
          activeColor: kPrimaryColor,
          index: bottomBarIndex,
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
              onPressed: () async {
                homeServices.addEmployee();
              },
            ),
            BottomNavigationItem(
              iconText: 'Мэдэгдэл',
              icon: Icon(Icons.favorite_border_rounded),
              iconSize: 22.sp,
              onPressed: () async {
                homeServices.employeesByCategory();
                print('done');
              },
            ),
            BottomNavigationItem(
              iconText: 'Профайл',
              icon: Icon(Icons.account_circle_outlined),
              iconSize: 22.sp,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeProfileScreen()));
                ;
              },
            )
          ],
        ),
      ),
    );
  }
}
