import 'package:test_fire/model/employee.dart';

class Booking {
  final Employee employee;
  final int bookingId;
  final int status;

  Booking({
    required this.employee,
    required this.bookingId,
    required this.status,
  });
}
