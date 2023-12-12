import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/employee1.dart';

class EmployeeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmployeesWithAccounts(List<Employee1> employees) async {
    for (var employee in employees) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: employee.email,
          password: employee.password,
        );

        String uid = userCredential.user!.uid;
        await _firestore.collection('employee').doc(uid).set(employee.toMap());

        print('Employee account and data added for: ${employee.fullName}');
      } catch (e) {
        print(
            'Error creating account or adding data for ${employee.fullName}: $e');
      }
    }
  }
}
