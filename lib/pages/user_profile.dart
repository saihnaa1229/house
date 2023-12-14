// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, avoid_print

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/user.dart';
import 'package:path/path.dart' as path;
import 'package:test_fire/widgets/custom_app_bar.dart';
import '../model/user.dart';
import '../util/constants.dart';
import '../widgets/alert_button.dart';
import '../widgets/custom_text_button.dart';
import 'auth/log_in_screen.dart';

class UserProfile extends StatefulWidget {
  final UserModel userData;
  const UserProfile({super.key, required this.userData});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CameraController? _cameraController;

  @override
  void dispose() {
    _cameraController?.dispose();
// TODO: implement dispose
    super.dispose();
  }

  String? id = UserPreferences.getUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: 'Хэрэглэгчийн хуудас',
        center: false,
        leadIcon: Icon(Icons.arrow_back_rounded),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  takePicture(context);
                },
                child: CircleAvatar(
                  radius: 50.sp,
                  backgroundImage: widget.userData.img.isNotEmpty
                      ? NetworkImage(widget.userData.img)
                      : AssetImage('assets/default-avatar.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 24),
              Text(
                '${widget.userData.username}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 24),
              ListTile(
                title: Text(
                  'Birth Date',
                  style: kBold12,
                ),
                subtitle: Text(widget.userData.birth),
                onTap: () {
                  _editUserInfo('birth', widget.userData.birth);
                },
              ),
              ListTile(
                title: Text(
                  'Email',
                  style: kBold12,
                ),
                subtitle: Text(widget.userData.email),
                onTap: () {
                  _editUserInfo('email', widget.userData.email);
                },
              ),
              ListTile(
                title: Text(
                  'Contact Number',
                  style: kBold12,
                ),
                subtitle: Text(widget.userData.number),
                onTap: () {
                  _editUserInfo('number', widget.userData.number);
                },
              ),
              ListTile(
                title: Text(
                  'Address',
                  style: kBold12,
                ),
                subtitle: Text(widget.userData.address),
                onTap: () {
                  _editUserInfo('address', widget.userData.address);
                },
              ),
              ListTile(
                title: Text(
                  'Баталгаажуулах пин',
                  style: kBold12,
                ),
                subtitle: Text('****'),
                onTap: () {
                  changePin(id, 'pin');
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
          case 'username':
            widget.userData.username = newValue;
            break;
          case 'email':
            widget.userData.email = newValue;
            break;
          case 'address':
            widget.userData.address = newValue;
            break;
          case 'number':
            widget.userData.number = newValue;
            break;
          case 'birth':
            widget.userData.birth = newValue;
            break;
          case 'pin':
            widget.userData.birth = newValue;
            break;
          default:
            break;
        }
      });

      Map<String, String> fieldMap = {
        'username': 'username',
        'email': 'email',
        'address': 'address',
        'number': 'number',
        'birth': 'birth',
        'pin': 'pin',
      };

      String firestoreField = fieldMap[field.toLowerCase()] ?? field;

      FirebaseFirestore.instance.collection('users').doc(id).update({
        firestoreField: newValue,
      }).catchError((error) {
        print('Error updating user info: $error');
      });
    }
  }

  Future<void> changePin(String? userId, String fieldName) async {
    // Get current passcode from the user
    final currentPasscode = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController textController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Current Passcode'),
          content: TextField(
            controller: textController,
            obscureText: true, // Obscure the text for a passcode field
            keyboardType: TextInputType.number, // Ensure numeric keyboard
            maxLength: 4, // Enforce 4-digit PIN length
            decoration: InputDecoration(hintText: 'Enter current 4-digit PIN'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () => Navigator.of(context).pop(textController.text),
            ),
          ],
        );
      },
    );

    if (currentPasscode != null && currentPasscode.isNotEmpty) {
      // Verify current passcode
      if (currentPasscode.length != 4 || !isNumeric(currentPasscode)) {
        print(
            'Current passcode is invalid. Please enter a 4-digit numeric PIN.');
        return;
      }

      bool isPasscodeCorrect =
          await verifyCurrentPasscode(userId!, currentPasscode);
      if (!isPasscodeCorrect) {
        print('Current passcode is incorrect');
        return;
      }

      // Get new passcode from the user
      final newValue = await showDialog<String>(
        context: context,
        builder: (context) {
          TextEditingController textController = TextEditingController();
          return AlertDialog(
            title: Text('Edit $fieldName'),
            content: TextField(
              controller: textController,
              obscureText: true, // Obscure the text for a passcode field
              keyboardType: TextInputType.number, // Ensure numeric keyboard
              maxLength: 4, // Enforce 4-digit PIN length
              decoration: InputDecoration(hintText: 'Enter new 4-digit PIN'),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () => Navigator.of(context).pop(textController.text),
              ),
            ],
          );
        },
      );

      if (newValue != null && newValue.isNotEmpty) {
        // Verify new passcode
        if (newValue.length != 4 || !isNumeric(newValue)) {
          print('New passcode is invalid. Please enter a 4-digit numeric PIN.');
          return;
        }

        // Update Firestore with the new passcode
        FirebaseFirestore.instance.collection('users').doc(userId).update({
          fieldName: newValue,
        }).catchError((error) {
          print('Error updating user info: $error');
        });
      }
    }
  }

  bool isNumeric(String value) {
    return int.tryParse(value) != null;
  }

  Future<bool> verifyCurrentPasscode(
    String userId,
    String currentPasscode,
  ) async {
    String fetchedPasscode = await fetchCurrentPasscode(userId);
    return fetchedPasscode == currentPasscode;
  }

  Future<String> fetchCurrentPasscode(String userId) async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userId).get();
    return userDoc['pin'];
  }

  Future<void> takePicture(BuildContext context) async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        print("No cameras available");
        return;
      }

      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();

      if (!_cameraController!.value.isInitialized) {
        print("Camera initialization failed");
        return;
      }

      final XFile file = await _cameraController!.takePicture();

      if (file != null) {
        uploadImageToFirebaseStorage(File(file.path), context);
      }
    } catch (e) {
      print("Error in takePicture: $e");
      // Consider showing this error to the user
    } finally {
      await _cameraController!.dispose();
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
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('users/$userId/${DateTime.now().millisecondsSinceEpoch}.png');

      // Upload the file
      await ref.putFile(image);

      // Get the URL
      String downloadURL = await ref.getDownloadURL();

      // Save the URL to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'img': downloadURL,
      });

      Navigator.pop(context); // Close the loading indicator

      // // Navigate to next screen or update UI
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   ),
      // ); // Replace with your actual next screen
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator
      print("Error in uploadImageToFirebaseStorage: $e"); // Handle error

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image: ${e.toString()}")),
      );
    }
  }
}
