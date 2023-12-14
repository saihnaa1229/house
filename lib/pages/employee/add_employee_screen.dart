import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;
import 'package:test_fire/util/user.dart';
import 'package:test_fire/widgets/select_category.dart';

import '../../util/constants.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_textfield.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _fullnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final _floorPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? userId = UserPreferences.getUser();
    String? selectedCategorys;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBarWithImage(
              leadIcon: Icons.arrow_back_rounded, text: 'Ажилтны мэд'),
          preferredSize: Size(100.w, 15.h),
        ),
        body: Container(
          margin: EdgeInsets.all(5.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // pickImageFromGallery(context);
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
                CustomTextField(
                  hintText: 'Full Name',
                  icon: false,
                  controller: _fullnameController,
                  obScure: false,
                  leadIcon: null,
                ),
                CustomTextField(
                  hintText: 'Nick Name',
                  icon: false,
                  controller: _nicknameController,
                  obScure: false,
                  leadIcon: null,
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: CustomTextField(
                      hintText: 'Date of Birth',
                      icon: false,
                      controller: _dateController,
                      obScure: false,
                      leadIcon: null,
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Phone Number',
                  icon: false,
                  controller: _phoneController,
                  obScure: false,
                  leadIcon: null,
                  inputType: true,
                ),
                CustomTextField(
                  hintText: 'Address',
                  icon: false,
                  controller: _addressController,
                  obScure: false,
                  leadIcon: null,
                ),
                CustomTextField(
                  hintText: 'Floor Price',
                  icon: false,
                  controller: _floorPriceController,
                  obScure: false,
                  leadIcon: null,
                ),
                SelectCategory(
                  onCategorySelected: (selectedCategory) {
                    // print('Selected Category: $selectedCategory');
                    selectedCategorys = selectedCategory;
                    // You can do something with the selected category here, such as setState or updating a model.
                  },
                ),
                CustomTextButton(
                  text: 'Continue',
                  onPressed: () {
                    print('Done');
                    print(selectedCategorys);
                    Navigator.pushNamed(context, 'HomeScreen');
                    // saveEmployeeInformation();
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

  Future<void> saveEmployeeInformation() async {
    Map<String, dynamic> profileData = {
      "fullName": _fullnameController.text.trim(),
      "nickname": _nicknameController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
      "dateOfBirth": _dateController.text.trim(),
      "address": _addressController.text.trim(),
    };

    await firestore.collection('employee').add(
          profileData,
          // SetOptions(merge: true),
        );

    Navigator.pushNamed(context, 'HomeScreen');
  }

  Future<void> uploadImages(String userId) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      for (var image in images) {
        File file = File(image.path);

        try {
          // Upload image to Firebase Storage
          TaskSnapshot snapshot = await FirebaseStorage.instance
              .ref('uploads/${image.name}')
              .putFile(file);

          // When upload is complete, get the download URL
          String downloadUrl = await snapshot.ref.getDownloadURL();

          // Upload the download URL to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('workImages')
              .add({
            'url': downloadUrl,
            'uploaded_at': FieldValue
                .serverTimestamp(), 
          });
        } catch (e) {
          // Handle errors
          print(e);
        }
      }
    }
  }
}
