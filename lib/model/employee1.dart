import 'package:cloud_firestore/cloud_firestore.dart';

class Employee1 {
  String? id;
  String fullName;
  String phoneNumber;
  String email;
  String address;
  DateTime dateOfBirth;
  String description;
  String categorytext;
  String category;
  DateTime uploadedAt;
  String password;
  int salary;
  String url;
  int review;
  double rating;

  Employee1(
      {this.id,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.dateOfBirth,
      required this.description,
      required this.categorytext,
      required this.category,
      required this.password,
      required this.uploadedAt,
      required this.url,
      required this.rating,
      required this.review,
      required this.salary});

  factory Employee1.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return Employee1(
      id: json['id'],
      rating: json['rating'],
      review: json['review'],
      salary: json['salary'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now(),
      description: json['description'] ?? '',
      categorytext: json['categorytext'] ?? '',
      category: json['category'] ?? '',
      url: json['url'] ?? '',
      uploadedAt: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now(),
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'review': review,
      'fullName': fullName,
      'salary': salary,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'description': description,
      'categorytext': categorytext.toLowerCase().trim(),
      'category': category,
      // 'password': password,  // Do not store passwords in the database
      'uploadedAt': uploadedAt.toIso8601String(),
      'url': url,
    };
  }
}
