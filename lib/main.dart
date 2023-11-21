import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/booking_screen.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';
import 'package:test_fire/pages/sign_in_screen.dart';
import 'package:test_fire/pages/splashScreen.dart';
import 'package:test_fire/util/constants.dart';

import 'pages/log_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
