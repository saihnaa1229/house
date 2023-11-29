// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/employee/create_employee_screen.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../model/admin.dart';
import '../util/constants.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/bottom_navigation_item.dart';
import '../widgets/info_tile.dart';
import 'auth/log_in_screen.dart';
import 'booking_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  int bottomBarIndex = 4;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Admin>(
          future: homeServices.getAdminData(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('User not found'));
            }
            Admin admin = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundImage: admin.img.isNotEmpty
                          ? NetworkImage(admin.img)
                          : AssetImage('assets/default-avatar.png')
                              as ImageProvider,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 24),
                    Text(admin.fullname, style: kbold18),
                    Text(
                      '${admin.username}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 24),
                    InfoTile(title: 'Birth Date', info: admin.birth),
                    InfoTile(title: 'Email', info: admin.email),
                    InfoTile(title: 'Contact Number', info: admin.number),
                    InfoTile(title: 'Address', info: admin.address),
                    CustomTextButton(
                      onPressed: () {
                        // Sign out the user when the button is pressed
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateEmployee()));
                      },
                      text: "Ажилтан нэмэх",
                    ),
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
                        builder: (context) => AdminProfileScreen()));
                ;
              },
            )
          ],
        ),
      ),
    );
  }
}
