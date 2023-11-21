import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test_fire/pages/sign_in_screen.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../util/constants.dart';
import 'homepage/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int activeIndex = 0;

  final List<String> imgList = [
    'assets/images/onBoarding1.png',
    'assets/images/onBoarding2.png',
    'assets/images/onBoarding3.png',
  ];

  final List<String> textList = [
    'We provide professional service at a friendly price',
    'The best results and your satisfaction is our top priority',
    "Let's make awesome changes to your home",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Image.asset(
                'assets/images/onBoarding3.png',
              ),
              Text(
                'We provide professional service at a friendly price',
                style: kSemibold18,
              ),
              CustomTextButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
