import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/util/constants.dart';

import '../../util/user.dart';
import '../../widgets/alert_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text_button.dart';
import '../auth/log_in_screen.dart';

class EmployeeProfile extends StatefulWidget {
  final Employee1 employee;
  const EmployeeProfile({super.key, required this.employee});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  String? id = UserPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: 'Ажилтны хуудас',
        center: false,
        leadIcon: Icon(Icons.arrow_back_rounded),
        bgColor: kScaffoldColor,
      ),
      body: Container(
        padding: EdgeInsets.all(5.w),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.sp,
                backgroundImage: NetworkImage(widget.employee.url),
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(height: 24),
              Text(
                widget.employee.fullName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              ListTile(
                  title: Text('Цахим шуудан'),
                  subtitle: Text(widget.employee.email)),
              ListTile(
                title: Text('Утасны дугаар'),
                subtitle: Text(widget.employee.phoneNumber),
                onTap: () {
                  _editUserInfo('phoneNumber', widget.employee.phoneNumber);
                },
              ),
              ListTile(
                title: Text('Хаяг'),
                subtitle: Text(widget.employee.address),
                onTap: () {
                  _editUserInfo('address', widget.employee.address);
                },
              ),
              ListTile(
                title: Text('Ангилал'),
                subtitle: Text(widget.employee.category),
                onTap: () {
                  _editUserInfo('category', widget.employee.category);
                },
              ),
              ListTile(
                title: Text('Үйлчилгээ'),
                subtitle: Text(widget.employee.categorytext),
                onTap: () {
                  _editUserInfo('categorytext', widget.employee.categorytext);
                },
              ),
              ListTile(
                title: Text('Цалин'),
                subtitle: Text('\$${widget.employee.salary}'),
                onTap: () {
                  _updateSalary();
                },
              ),
              CustomTextButton(
                onPressed: () {
                  // Sign out the user when the button is pressed
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                text: "Гарах",
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _editUserInfo(String field, String currentValue) async {
    final newValue = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController textController =
            TextEditingController(text: currentValue);
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(controller: textController),
          actions: [
            AlertTextButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
            AlertTextButton(
              text: 'Save',
              onPressed: () => Navigator.of(context).pop(textController.text),
            ),
          ],
        );
      },
    );

    if (newValue != null && newValue != currentValue) {
      setState(() {
        // Map the input field to the UserModel field
        switch (field.toLowerCase()) {
          case 'email':
            widget.employee.email = newValue;
            break;
          case 'address':
            widget.employee.address = newValue;
            break;
          case 'number':
            widget.employee.phoneNumber = newValue;
            break;
          case 'categorytext':
            widget.employee.categorytext = newValue;
            break;

          default:
            break;
        }
      });

      Map<String, String> fieldMap = {
        'email': 'email',
        'address': 'address',
        'number': 'number',
        'birth': 'birth',
      };

      String firestoreField = fieldMap[field.toLowerCase()] ?? field;

      FirebaseFirestore.instance.collection('admin').doc(id).update({
        firestoreField: newValue,
      }).catchError((error) {
        print('Error updating user info: $error');
      });
    }
  }

  void _updateSalary() async {
    final newSalary = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController salaryController =
            TextEditingController(text: widget.employee.salary.toString());
        return AlertDialog(
          title: Text('Update Salary'),
          content: TextField(
            controller: salaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter new salary'),
          ),
          actions: [
            AlertTextButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
            AlertTextButton(
              text: 'Save',
              onPressed: () => Navigator.of(context).pop(salaryController.text),
            ),
          ],
        );
      },
    );

    if (newSalary != null && newSalary.isNotEmpty) {
      int updatedSalary = int.tryParse(newSalary) ?? widget.employee.salary;
      setState(() {
        widget.employee.salary = updatedSalary;
      });

      FirebaseFirestore.instance.collection('employee').doc(id).update({
        'salary': updatedSalary,
      }).then((_) {
        print("Salary updated successfully");
      }).catchError((error) {
        print('Error updating salary: $error');
      });
    }
  }
}
