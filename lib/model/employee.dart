import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String name;
  final String img;
  final int employeeId;
  final String category;
  final double salary;
  final double rating;
  final int review;
  final bool favorite;

  Employee({
    required this.category,
    required this.name,
    required this.employeeId,
    required this.img,
    required this.rating,
    required this.review,
    required this.salary,
    required this.favorite,
  });

  factory Employee.fromDocumentSnapshotMap(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return Employee(
      name: json['name'],
      img: json['img'],
      employeeId: json['employeeId'],
      category: json['category'],
      salary: json['salary'],
      rating: json['rating'],
      review: json['review'],
      favorite: json['favorite'],
      // Initialize other fields from json
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'img': img,
      'employeeId': employeeId,
      'category': category,
      'salary': salary,
      'rating': rating,
      'review': review,
      'favorite': favorite
    };
  }
}
