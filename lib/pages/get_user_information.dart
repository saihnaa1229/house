// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:test_fire/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../widgets/app_bar.dart';

class GetUserInformation extends StatefulWidget {
  const GetUserInformation({super.key});

  @override
  State<GetUserInformation> createState() => _GetUserInformationState();
}

class _GetUserInformationState extends State<GetUserInformation> {
  final _fullnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBarWithImage(
              leadIcon: Icons.arrow_back_rounded, text: 'Fill your Profile'),
          preferredSize: Size(100.w, 15.h),
        ),
        body: Container(
          margin: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    pickImageFromGallery(context);
                  },
                  child: Container(
                    height: 20.h,
                    width: 20.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.h),
                        boxShadow: kBoxShadow),
                    child: Image.asset('assets/images/profile.webp'),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  hintText: 'Овог',
                  icon: false,
                  controller: _fullnameController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  hintText: 'Нэр',
                  icon: false,
                  controller: _nicknameController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: CustomTextField(
                      hintText: 'Төрсөн өдөр',
                      icon: false,
                      controller: _dateController,
                      obScure: false,
                      leadIcon: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  hintText: 'Утасны дугаар',
                  icon: false,
                  controller: _phoneController,
                  obScure: false,
                  leadIcon: null,
                  inputType: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  hintText: 'Хаяг',
                  icon: false,
                  controller: _addressController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextButton(
                  text: 'Үргэлжлүүлэх',
                  onPressed: () {
                    print('Done');
                    saveProfileInformation();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      uploadImageToFirebaseStorage(File(image.path), context);
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadImageToFirebaseStorage(
      File image, BuildContext context) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Showing a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('users/$userId/${path.basename(image.path)}');

      await ref.putFile(image);

      String downloadURL = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'photoURL': downloadURL,
      });

      Navigator.pop(context); // Close the loading indicator
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator
      print(e); // Handle error

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: ${e.toString()}")),
      );
    }
  }

  Future<void> saveProfileInformation() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> profileData = {
      "fullName": _fullnameController.text.trim(),
      "nickname": _nicknameController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
      "dateOfBirth": _dateController.text.trim(),
      "address": _addressController.text.trim(),
      "pin": 0000,
    };

    await firestore.collection('users').doc(userId).set(
          profileData,
          SetOptions(merge: true),
        );

    Navigator.pushNamed(context, 'HomeScreen');
  }
}
