// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:test_fire/widgets/custom_textfield.dart';

import '/util/utils.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

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
                  kSigninText,
                  style: kbold34,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextField(
                  hintText: 'Цахим шуудан',
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
                  hintText: 'Нууц үг',
                  icon: true,
                  label: null,
                  controller: _passwordController,
                  obScure: true,
                  leadIcon: FontAwesomeIcons.lock,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Нууц үг давтах',
                  icon: true,
                  label: null,
                  controller: _rePasswordController,
                  obScure: false,
                  leadIcon: FontAwesomeIcons.lock,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextButton(
                    text: 'Бүртгүүлэх',
                    onPressed: () {
                      signUp(context);
                    }),
                SizedBox(height: 4.h),
                Text(
                  'Өөр холбоосоор нэвтрэх',
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
                      'Бүртгэлтэй хаяг байгаа?',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Нэвтрэх',
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

  Future signUp(BuildContext context) async {
    if (_passwordController.text.trim() != _rePasswordController.text.trim()) {
      Utils.showSnackBar("Passwords do not match");
      return; 
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;

      Map<String, dynamic> userData = {
        "email": _emailController.text.trim(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(userData);

      Navigator.pushNamed(context, 'GetUserInformation');
    } on FirebaseAuthException catch (error) {
      print('--------------------------------');
      print(error);
      Utils.showSnackBar(error
          .message);
    } catch (e) {
      print('ssssssssssssssssssssssssss');
      // Handle any other errors
      print(e);
      Utils.showSnackBar(e.toString());
    }
  }
}
