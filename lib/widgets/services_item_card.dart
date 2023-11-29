import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/services.dart';
import 'package:test_fire/pages/category_employee_screen.dart';
import 'package:test_fire/util/constants.dart';

class ServiceItemCard extends StatelessWidget {
  final ServiceItem serviceItem;

  ServiceItemCard({required this.serviceItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreenState(
              docId: serviceItem.name,
            ),
          ),
        );
      }),
      child: Container(
        width: 20.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.h),
                // border: Border.all(width: 1.sp, color: serviceItem.color),
                color: serviceItem.color.withOpacity(0.25),
              ),
              child: Column(
                children: [
                  Icon(
                    serviceItem.icon,
                    color: serviceItem.color,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.w,
            ),
            Text(
              serviceItem.name,
              style: kRegular10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
