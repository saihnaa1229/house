import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String userId;
  final String employeeId;
  final DateTime selectedDay;
  final String startTime;
  final String payment;
  final int quantity;
  final String address;
  final String status;

  BookingModel({
    required this.bookingId,
    required this.userId,
    required this.employeeId,
    required this.selectedDay,
    required this.payment,
    required this.quantity,
    required this.address,
    required this.status,
    required this.startTime,
  });

  factory BookingModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return BookingModel(
      bookingId: doc.id,
      userId: json['userId'] ?? '',
      employeeId: json['employeeId'] ?? '',
      selectedDay: (json['selectedDay'] as Timestamp).toDate(),
      payment: json['payment'] ?? '',
      quantity: json['quantity'] ?? 0,
      address: json['address'] ?? '',
      status: json['status'] ?? '',
      startTime: json['startTime'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'employeeId': employeeId,
      'selectedDay': selectedDay,
      'payment': payment,
      'quantity': quantity,
      'address': address,
      'status': status,
      'startTime': startTime
    };
  }
}
