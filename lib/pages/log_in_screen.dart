import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:test_fire/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          bgColor: kScaffoldColor,
          leadIcon: Icon(Icons.arrow_back_rounded),
        ),
        body: Container(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  kLoginText,
                  style: kbold34,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextField(
                  hintText: 'Email',
                  icon: false,
                  label: null,
                  controller: _emailController,
                  obScure: false,
                  inputType: true,
                  leadIcon: FontAwesomeIcons.envelope,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Password',
                  icon: true,
                  label: null,
                  controller: _passwordController,
                  obScure: true,
                  leadIcon: FontAwesomeIcons.lock,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextButton(
                    text: 'Sign up',
                    onPressed: () {
                      print(_emailController.text);
                      print(_passwordController.text);
                    }),
                SizedBox(height: 4.h),
                Text(
                  'Forget the password',
                  style: kRegularBlue12,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Or contunie with',
                  style: kRegular12,
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    rowItem(img: 'assets/images/apple_logo.jpg'),
                    rowItem(img: 'assets/images/fb_logo.png'),
                    rowItem(img: 'assets/images/google_logo.webp'),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Sign in',
                        style: kRegularBlue12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowItem({required String img}) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
          border: Border.all(width: 1.sp, color: kTextFieldColor),
          borderRadius: BorderRadius.circular(3.w)),
      child: Image.asset(
        img,
        height: 3.h,
      ),
    );
  }
}
