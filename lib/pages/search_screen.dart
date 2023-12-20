import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/pages/employee/employee_screen.dart';
import 'package:test_fire/pages/filter_screen.dart';
import 'dart:async';

import '../util/constants.dart';

class MySearchScreen extends StatefulWidget {
  @override
  _MySearchScreenState createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Employee1> searchResults = [];

  Timer? searchDebounce;

  @override
  void initState() {
    super.initState();
  }

  void searchEmployee(String query) async {
    String searchQuery = query.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('employee')
          .orderBy('categorytext')
          .startAt([searchQuery]).endAt([searchQuery + '\uf8ff']).get();

      List<Employee1> results = snapshot.docs
          .map((doc) => Employee1.fromDocumentSnapshot(doc))
          .toList();

      setState(() {
        searchResults = results;
      });
    } catch (error) {
      print('Error searching products: $error');
    }
  }

  void onSearchChanged(String query) {
    if (searchDebounce?.isActive ?? false) searchDebounce!.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 500), () {
      searchEmployee(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight;
    if (searchResults.isEmpty) {
      containerHeight = 11.h; // Height for no search results
    } else if (searchResults.length == 1) {
      containerHeight = 20.h; // Height for exactly one search result
    } else {
      containerHeight = (searchResults.length * 13.h)
          .clamp(10.h, 60.h); // Dynamic height for more than one result
    }
    return Container(
      height: containerHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: kHomeScreenHintText,
                hintStyle: kHomeScreenHintTextStyle, // Your hint text style
                filled: true,
                fillColor: kTextFieldColor,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(),
                      ),
                    );
                  },
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.w),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final product = searchResults[index];
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeScreen(
                          employeeId: product.id!,
                          employee: product,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 2.w),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                        color: kScaffoldColor,
                        border: Border(
                          bottom:
                              BorderSide(width: 1.5.sp, color: kHintTextColor),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Image.network(
                                product.url,
                                height: 8.h,
                                width: 10.h,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    product.fullName,
                                    style: kBold12,
                                  ),
                                ),
                                Text(
                                  ("${product.categorytext}"),
                                  style: kRegular12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchDebounce?.cancel();
    super.dispose();
  }
}
