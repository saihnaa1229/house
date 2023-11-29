import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String userId;
  final String img;
  final String fullname;
  final String username;
  final String birth;
  final String email;
  final String number;
  final String address;

  Admin({
    required this.userId,
    required this.img,
    required this.address,
    required this.birth,
    required this.email,
    required this.fullname,
    required this.number,
    required this.username,
  });

  factory Admin.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Admin(
      userId: doc.id,
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      username: json['username'] ?? '',
      birth: json['birth'] ?? '',
      address: json['address'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
