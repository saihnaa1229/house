import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/employee/congrats_screen.dart';
import 'package:test_fire/util/employee.dart';
import 'package:test_fire/widgets/custom_text_button.dart';
import 'package:path/path.dart' as path;
import '../../util/constants.dart';
import '../../widgets/custom_app_bar.dart';

class AddWorkImages extends StatefulWidget {
  const AddWorkImages({super.key});

  @override
  State<AddWorkImages> createState() => _AddWorkImagesState();
}

class _AddWorkImagesState extends State<AddWorkImages> {
  String? employeeId = EmployeePreferences.getEmployee();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadIcon: Icon(Icons.arrow_back_rounded),
          bgColor: kScaffoldColor,
          title: 'Ажлын зураг оруулах',
          center: false,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 20.w),
          child: InkWell(
            onTap: () => pickImageFromGallery(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: kScaffoldColor,
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                          width: 0.5.sp, color: kSearchHintTextColor),
                      boxShadow: kBoxShadow),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.w),
                          color: kPrimaryColor.withOpacity(0.1),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.folder,
                            color: kPrimaryColor,
                            size: 10.w,
                          ),
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: kMedium14,
                      )
                    ],
                  ),
                ),
                CustomTextButton(
                    text: 'Үргэлжлүүлэх',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CongratScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
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
          .child('employee/$employeeId/${path.basename(image.path)}');

      await ref.putFile(image);

      // Get the URL
      String downloadURL = await ref.getDownloadURL();

      // Save the URL to Firestore
      await FirebaseFirestore.instance
          .collection('employee')
          .doc(employeeId)
          .collection('workImages')
          .add({
        'url': downloadURL,
        'uploaded_at': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context); // Close the loading indicator
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator
      print(e); // Handle error

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: ${e.toString()}")),
      );
    }
  }
}
