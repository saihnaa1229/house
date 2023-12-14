import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../services/home_service.dart';
import '../util/constants.dart';
import '../util/user.dart';
import 'employee_card.dart';

class CategorySelect extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategorySelect({super.key, required this.onCategorySelected});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  List<String> _categories = HomeServices.getServicesList();
  int _selectedChipIndex = 0;
  Future<List<EmployeeCard>>? _employees;
  String value = '';

  Future<void> loadData() async {
    _employees = homeServices.getAllEmployees();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getValue(_selectedChipIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: ChoiceChip(
              label: Text(
                _categories[index],
                style: kMedium14,
              ),
              selected: _selectedChipIndex == index,
              selectedColor: Colors.blue,
              onSelected: (bool selected) {
                setState(() {
                  _selectedChipIndex = selected ? index : 0;
                });
              },
              labelStyle: TextStyle(
                color:
                    _selectedChipIndex == index ? Colors.white : kPrimaryColor,
              ),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(width: 2.sp, color: kPrimaryColor),
              ),
            ),
          );
        },
      ),
    );
  }

  String getValue(int index) {
    // Map the input field to the UserModel field
    switch (index) {
      case 0:
        value = 'Цэвэрлэгээ';
        break;
      case 1:
        value = 'Засвар';
        break;
      case 2:
        value = 'Угаалга';
        break;
      case 3:
        value = 'Цахилгаан хэрэгсэл';
        break;
      case 4:
        value = 'Сантехник';
        break;
      case 5:
        value = 'Гоо сайхан';
        break;
      case 6:
        value = 'Массаж';
        break;
      case 7:
        value = 'Будах';
        break;

      default:
        break;
    }

    return value;
  }
}
