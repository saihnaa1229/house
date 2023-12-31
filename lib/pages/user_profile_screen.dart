// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/widgets/bottomNavigationBar/custom_bottom_navigation.dart';
import '../model/user.dart';
import '../util/constants.dart';
import 'user_profile.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  int bottomBarIndex = 4;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<UserModel>(
          future: homeServices.getUserData(userId),
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
              UserModel userModel = snapshot.data!;
              // UserPreferences.setPin(userModel.pin.);
              return Container(
                height: 100.h,
                width: 100.w,
                child: UserProfile(userData: userModel),
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
