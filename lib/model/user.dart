import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String img;
  String username;
  String birth;
  String email;
  String number;
  String address;
  String pin;

  UserModel(
      {required this.userId,
      required this.img,
      required this.address,
      required this.birth,
      required this.email,
      required this.number,
      required this.username,
      required this.pin});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id,
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      username: json['username'] ?? '',
      birth: json['birth'] ?? '',
      address: json['address'] ?? '',
      img: json['img'] ?? '',
      pin: json['pin'] ?? '',
    );
  }
}
