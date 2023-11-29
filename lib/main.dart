import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/employee/about_employee.dart';
import 'package:test_fire/pages/employee/add_employee_screen.dart';
import 'package:test_fire/pages/booking_screen.dart';
import 'package:test_fire/pages/employee/create_employee_screen.dart';
import 'package:test_fire/pages/category_employee_screen.dart';
import 'package:test_fire/pages/employee/get_employee_information.dart';
import 'package:test_fire/pages/get_user_information.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';
import 'package:test_fire/pages/auth/sign_up_screen.dart';
import 'package:test_fire/pages/splashScreen.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/util/employee.dart';
import 'pages/employee/employee_screen.dart';
import 'pages/employee/employee_work_images.dart';
import 'util/user.dart';
import 'util/utils.dart';
import 'pages//auth/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await EmployeePreferences.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: Utils.messengerKey,
          routes: {
            'HomeScreen': (context) => HomeScreen(),
            'GetUserInformation': (context) => GetUserInformation(),
            'GetEmployeeInformation': (context) => GetEmployeeInformation(),
            'AboutEmployee': (context) => AboutEmployee(),
            'AddWorkImages': (context) => AddWorkImages(),
            // 'EmployeeScreen': (context) => EmployeeScreen(),
            // Define other routes as needed
          },
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: kScaffoldColor),
          home: SplashScreen(
              // productId: 1,
              ),
        );
      },
    );
  }
}
