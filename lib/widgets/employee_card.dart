import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/model/services.dart';
import 'package:test_fire/pages/employee/employee_screen.dart';
import 'package:test_fire/util/constants.dart';

class EmployeeCard extends StatelessWidget {
  final Employee1 employee;
  final String employeeId;

  EmployeeCard({required this.employee, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeScreen(
              employeeId: employeeId,
              employee: employee,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.5.w),
              height: 30.w,
              width: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  employee.url,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.fullName,
                    style: kRegular10,
                  ),
                  Text(
                    employee.categorytext,
                    style: kSemibold14,
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  Text(
                    '₮${employee.salary.toString()}',
                    style: kBold14,
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[600], size: 20),
                      SizedBox(width: 1.5.w),
                      Text(
                        '${employee.rating}',
                        style: kRegular10,
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        '${employee.review} reviews',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                print('object');
              },
              icon: Icon(
                Icons.bookmark_border_rounded,
                size: 20.sp,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
