import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/employee.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../../util/constants.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/select_category.dart';

class AboutEmployee extends StatefulWidget {
  const AboutEmployee({super.key});

  @override
  State<AboutEmployee> createState() => _AboutEmployeeState();
}

class _AboutEmployeeState extends State<AboutEmployee> {
  String? selectedCategory;

  final _aboutEmployeeController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String? employeeId = EmployeePreferences.getEmployee();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadIcon: Icon(Icons.arrow_back_rounded),
          bgColor: kScaffoldColor,
          title: 'Ажилтны тухай',
          center: false,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Өөрийнхөө тухай бичээрэй',
                  style: kbold18,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  margin: EdgeInsets.all(2.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    boxShadow: kBoxShadow,
                    color: kScaffoldColor,
                    borderRadius: BorderRadius.circular(5.w),
                  ),
                  height: 30.h, // Set the desired height here
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _aboutEmployeeController,
                      focusNode: focusNode,
                      maxLines: null, // Allow multiple lines of text
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Өөрийнхөө тухай бичээрэй',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SelectCategory(
                  onCategorySelected: (selectCategory) {
                    // print('Selected Category: $selectedCategory');
                    selectedCategory = selectCategory;
                    // You can do something with the selected category here, such as setState or updating a model.
                  },
                ),
                CustomTextButton(
                    text: 'Хадгалах',
                    onPressed: () {
                      print(selectedCategory);
                      // saveEmployeeInformation();
                      Navigator.pushNamed(context, 'AddWorkImages');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveEmployeeInformation() async {
    Map<String, dynamic> profileData = {
      "description": _aboutEmployeeController.text.trim(),
      "category": selectedCategory
    };

    await firestore.collection('employee').doc(employeeId).set(
          profileData,
          SetOptions(merge: true),
        );

    Navigator.pushNamed(context, 'AddWorkImages');
  }
}
