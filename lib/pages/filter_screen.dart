import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/pages/search_screen.dart';
import 'package:test_fire/widgets/alert_button.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/rating.dart';
import 'package:test_fire/widgets/slider_bar.dart';

import '../model/employee1.dart';
import '../util/constants.dart';
import '../widgets/category_select.dart';
import 'employee/employee_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController searchController = TextEditingController();
  List<Employee1> searchResults = [];
  String? _categorySelect;

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
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return buildBottomSheet();
                            });
                      },
                    ), // Your text field fill color

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          3.w), // Adjust the border radius as needed
                      borderSide: BorderSide.none, // No border side
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
                              bottom: BorderSide(
                                  width: 1.5.sp, color: kHintTextColor),
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
                                    product.url, // Use ProductDetail property
                                    height: 8.h,
                                    width: 10.h,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        product
                                            .fullName, // Use ProductDetail property
                                        style: kBold12,
                                      ),
                                    ),
                                    Text(
                                      ("${product.categorytext}"), // Use ProductDetail property
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
        ),
      ),
    );
  }

  Widget buildBottomSheet() {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Шүүлтүүр', style: kBold14)),
          Divider(
            thickness: 1.sp,
            color: kHintTextColor,
          ),
          Text(
            'Төрөл',
            style: kBold12,
          ),
          CategorySelect(onCategorySelected: (selectedValue) {
            _categorySelect = selectedValue;
          }),
          Text(
            'Үнэ',
            style: kBold12,
          ),
          PriceSlider(),
          Text(
            'Үнэлгээ',
            style: kBold12,
          ),
          RatingWidget(),
          Divider(
            thickness: 1.sp,
            color: kHintTextColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AlertTextButton(
                  text: 'Буцах',
                  onPressed: () {
                    CategorySelect(onCategorySelected: (selectedValue) {
                      _categorySelect = selectedValue;
                    });
                    print(_categorySelect);
                  }),
              AlertTextButton(text: 'Шүүх', onPressed: () {})
            ],
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
