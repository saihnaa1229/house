import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/model/services.dart';
import 'package:test_fire/util/constants.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
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
            height: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              employee.img,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: kRegular10,
                  ),
                  Text(
                    employee.category,
                    style: kSemibold14,
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  Text(
                    '\$${employee.salary.toString()}',
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
                        employee.rating.toString(),
                        style: kRegular10,
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        '${employee.review.toString()} reviews',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.bookmark,
            color: Colors.purple,
            size: 30,
          ),
        ],
      ),
    );
  }
}
