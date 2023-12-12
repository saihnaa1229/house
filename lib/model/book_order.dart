import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String userId;
  final String employeeId;
  final DateTime selectedDay;
  final String timeSlot;
  final int quantity;
  final String address;
  final String status;

  BookingModel({
    required this.bookingId,
    required this.userId,
    required this.employeeId,
    required this.selectedDay,
    required this.timeSlot,
    required this.quantity,
    required this.address,
    required this.status,
  });

  factory BookingModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return BookingModel(
      bookingId: doc.id,
      userId: json['userId'] ?? '',
      employeeId: json['employeeId'] ?? '',
      selectedDay: (json['selectedDay'] as Timestamp).toDate(),
      timeSlot: json['timeSlot'] ?? '',
      quantity: json['quantity'] ?? 0,
      address: json['address'] ?? '',
      status: json['status'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'employeeId': employeeId,
      'selectedDay': selectedDay,
      'timeSlot': timeSlot,
      'quantity': quantity,
      'address': address,
      'status': status,
    };
  }
}
