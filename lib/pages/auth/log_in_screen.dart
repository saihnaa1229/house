import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/util/user.dart';
import 'package:test_fire/util/utils.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:test_fire/widgets/custom_textfield.dart';

import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  hintText: 'Цахим шуудан',
                  icon: false,
                  label: null,
                  controller: _emailController,
                  obScure: false,
                  inputType: true, // Fix the input type
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
                  height: 5.h,
                ),
                CustomTextButton(
                  text: 'Нэвтрэх',
                  onPressed: () {
                    Login(context); // Pass the context to Login method
                  },
                ),
                SizedBox(height: 4.h),
                Text(
                  'Нууц үг мартсан',
                  style: kRegularBlue12,
                ),
                SizedBox(
                  height: 5.h,
                ),
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
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Бүртгүүлэх',
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
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Image.asset(
        img,
        height: 3.h,
      ),
    );
  }

  Future Login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userData.exists) {
        Map<String, dynamic> userInfo = userData.data() as Map<String, dynamic>;
        // groceryModel.userId = userId;
        UserPreferences.setUser(userId);
        
        print('User Info: $userInfo');
      } else {
        print('No user data found in Firestore');
      }

      Navigator.pushNamed(context, 'HomeScreen');
    } on FirebaseAuthException catch (error) {
      print('--------------------------------');

      print(error);
      Utils.showSnackBar(error.message); // Pass the context
    } catch (e) {
      print('ssssssssssssssssssssssssss');
      print(e);
      Utils.showSnackBar(e.toString()); // Pass the context
    }
  }
}
