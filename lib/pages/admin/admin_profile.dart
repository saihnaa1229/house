import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../../model/admin.dart';
import '../../util/constants.dart';
import '../../util/user.dart';
import '../../widgets/alert_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../auth/log_in_screen.dart';
import '../employee/create_employee_screen.dart';

class AdminProfile extends StatefulWidget {
  final Admin admin;
  const AdminProfile({super.key, required this.admin});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String? id = UserPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Админ хуудас',
          center: false,
          leadIcon: Icon(Icons.arrow_back_rounded),
          bgColor: kScaffoldColor,
        ),
        body: Container(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.sp,
                backgroundImage: widget.admin.img.isNotEmpty
                    ? NetworkImage(widget.admin.img)
                    : AssetImage('assets/default-avatar.png') as ImageProvider,
                backgroundColor: Colors.grey.shade300,
              ),
              SizedBox(height: 24),
              ListTile(
                title: Text(
                  'Birth Date',
                  style: kBold12,
                ),
                subtitle: Text(widget.admin.birth),
                onTap: () {
                  _editUserInfo('birth', widget.admin.birth);
                },
              ),
              ListTile(
                title: Text(
                  'Email',
                  style: kBold12,
                ),
                subtitle: Text(widget.admin.email),
                onTap: () {
                  _editUserInfo('email', widget.admin.email);
                },
              ),
              ListTile(
                title: Text(
                  'Contact Number',
                  style: kBold12,
                ),
                subtitle: Text(widget.admin.number),
                onTap: () {
                  _editUserInfo('number', widget.admin.number);
                },
              ),
              ListTile(
                title: Text(
                  'Address',
                  style: kBold12,
                ),
                subtitle: Text(widget.admin.address),
                onTap: () {
                  _editUserInfo('address', widget.admin.address);
                },
              ),
              ListTile(
                title: Text(
                  'Ажилтан нэмэх',
                  style: kBold12,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateEmployee()));
                },
              ),
              SizedBox(
                height: 10.w,
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
    );
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
            widget.admin.email = newValue;
            break;
          case 'address':
            widget.admin.address = newValue;
            break;
          case 'number':
            widget.admin.number = newValue;
            break;
          case 'birth':
            widget.admin.birth = newValue;
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
}
