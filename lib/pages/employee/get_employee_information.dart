// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/util/employee.dart';

import '../../util/constants.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/custom_textfield.dart';

class GetEmployeeInformation extends StatefulWidget {
  const GetEmployeeInformation({super.key});

  @override
  State<GetEmployeeInformation> createState() => _GetEmployeeInformationState();
}

class _GetEmployeeInformationState extends State<GetEmployeeInformation> {
  final _fullnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final _floorPriceController = TextEditingController();
  String? employeeId;
  String? selectedCategorys;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    employeeId = EmployeePreferences.getEmployee();
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    homeServices.pickImageFromGallery(
                        context, 'employee', employeeId);
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
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Овог',
                  icon: false,
                  controller: _fullnameController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Нэр',
                  icon: false,
                  controller: _nicknameController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 3.h,
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: CustomTextField(
                      hintText: 'Төрсөн он, сар, өдөр',
                      icon: false,
                      controller: _dateController,
                      obScure: false,
                      leadIcon: null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
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
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Хаяг',
                  icon: false,
                  controller: _addressController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextField(
                  hintText: 'Үнэ',
                  icon: false,
                  controller: _floorPriceController,
                  obScure: false,
                  leadIcon: null,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextButton(
                  text: 'Үргэлжлүүэх',
                  onPressed: () {
                    print('Done');
                    print(selectedCategorys);
                    print(employeeId);
                    Navigator.pushNamed(context, 'AboutEmployee');

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

    await firestore.collection('employee').doc(employeeId).set(
          profileData,
          SetOptions(merge: true),
        );

    Navigator.pushNamed(context, 'AboutEmployee');
  }
}
