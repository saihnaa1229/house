import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String userId;
  String img;
  String fullname;
  String birth;
  String email;
  String number;
  String address;

  Admin({
    required this.userId,
    required this.img,
    required this.address,
    required this.birth,
    required this.email,
    required this.fullname,
    required this.number,
  });

  factory Admin.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Admin(
      userId: doc.id,
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      birth: json['birth'] ?? '',
      address: json['address'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
