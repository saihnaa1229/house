// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/employee/employee_profile.dart';
import 'package:test_fire/widgets/bottomNavigationBar/custom_bottom_navigation.dart';
import '../../model/employee1.dart';
import '../../util/constants.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/info_tile.dart';
import '../auth/log_in_screen.dart';

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
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Employee not found'));
            } else if (snapshot.hasData) {
              Employee1 employee = snapshot.data!;

              return Container(
                height: 100.h,
                width: 100.w,
                child: EmployeeProfile(employee: employee),
              );
            } else {
              return Text('No user data available');
            }
          },
        ),
        bottomNavigationBar:
            BottomNavigationContainer(bottomBarIndex: bottomBarIndex),
      ),
    );
  }
}
