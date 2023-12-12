// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/admin/admin_profile.dart';
import 'package:test_fire/pages/employee/create_employee_screen.dart';
import 'package:test_fire/widgets/bottomNavigationBar/custom_bottom_navigation.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import '../../model/admin.dart';
import '../../util/constants.dart';
import '../../widgets/info_tile.dart';
import '../auth/log_in_screen.dart';

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
            } else if (snapshot.hasData) {
              Admin admin = snapshot.data!;
              return Container(
                height: 100.h,
                width: 100.w,
                child: AdminProfile(admin: admin),
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
