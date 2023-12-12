import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/util/employee.dart';
import 'package:test_fire/util/user.dart';
import '../../util/constants.dart';
import '../../util/utils.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_textfield.dart';

class CreateEmployee extends StatefulWidget {
  const CreateEmployee({super.key});

  @override
  State<CreateEmployee> createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  HomeServices homeServices = HomeServices();
  String? role;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ажилтны хаяг үүсгэх',
                  style: kbold24,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Ажилтны нэр',
                  style: kMedium14,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Ажилтны цахим шуудан',
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
                Text(
                  'Нууц үг',
                  style: kMedium14,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Нууц үг оруулах',
                  icon: true,
                  label: null,
                  controller: _passwordController,
                  obScure: false,
                  leadIcon: FontAwesomeIcons.lock,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Нууц үг давтах',
                  style: kMedium14,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Нууц үг оруулах',
                  icon: true,
                  label: null,
                  controller: _rePasswordController,
                  obScure: false,
                  leadIcon: FontAwesomeIcons.lock,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextButton(
                    text: 'Үүсгэх',
                    onPressed: () {
                      Navigator.pushNamed(context, 'GetEmployeeInformation');
                      // createEmployee(context);
                    }),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createEmployee(BuildContext context) async {
    if (_passwordController.text.trim() != _rePasswordController.text.trim()) {
      Utils.showSnackBar("Passwords do not match");
      return; // Exit the function early
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      String employeeId = userCredential.user!.uid;

      // Set up data to be saved in Firestore (customize as needed)
      Map<String, dynamic> userData = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      };

      // Store the user data in Firestore
      await FirebaseFirestore.instance
          .collection('employee')
          .doc(employeeId)
          .set(userData);

      EmployeePreferences.setEmployee(employeeId);
      Navigator.pushNamed(context, 'GetEmployeeInformation');
    } on FirebaseAuthException catch (error) {
      print('--------------------------------');
      print(error);
      Utils.showSnackBar(error.message);
    } catch (e) {
      print('ssssssssssssssssssssssssss');
      print(e);
      Utils.showSnackBar(e.toString());
    }
  }
}
