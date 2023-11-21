import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee.dart';

import 'employee_card.dart';
import 'services_item_card.dart';

class EmployeeContainer extends StatelessWidget {
  final List<EmployeeCard> employee;

  EmployeeContainer({
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Wrap(spacing: 5.5.w, runSpacing: 4.w, children: employee),
    );
  }
}
