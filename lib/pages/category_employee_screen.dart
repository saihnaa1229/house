import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';

import '../services/home_service.dart';
import '../widgets/employee_card.dart';
import '../widgets/employee_container.dart';

class CategoryScreenState extends StatefulWidget {
  final String docId;
  const CategoryScreenState({super.key, required this.docId});

  @override
  State<CategoryScreenState> createState() => _CategoryScreenStateState();
}

class _CategoryScreenStateState extends State<CategoryScreenState> {
  Future<List<EmployeeCard>>? _employeeItems;

  @override
  void initState() {
    super.initState();
    _employeeItems = homeServices.getEmployeeDetails(widget.docId);
    // Assuming that HomeService is instantiated correctly.
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kScaffoldColor,
        padding: EdgeInsets.only(top: 5.w),
        child: Scaffold(
          appBar: CustomAppBar(
            leadIcon: Icon(Icons.arrow_back_rounded),
            title: widget.docId,
            bgColor: kScaffoldColor,
            actionIcon: Icon(Icons.search),
            center: false,
          ),
          body: Container(
            padding: EdgeInsets.all(5.w),
            child: FutureBuilder<List<EmployeeCard>>(
              future: _employeeItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<EmployeeCard> employeeItems = snapshot.data!;
                  return Wrap(
                    children: [
                      EmployeeContainer(employee: employeeItems),
                    ],
                  );
                } else {
                  return Text("No products found");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
