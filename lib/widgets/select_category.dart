import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/util/constants.dart';

class SelectCategory extends StatefulWidget {
  final Function(String) onCategorySelected;

  const SelectCategory({super.key, required this.onCategorySelected});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  int _selectedChipIndex = 0;
  List<String> _categories = HomeServices.getServicesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Үйлчилгээний төрөл',
          style: kBold14,
        ),
        SizedBox(
          height: 3.h,
        ),
        Container(
          // Make the container take up the full height available.
          child: Wrap(
            spacing: 2.w, // Horizontal space between chips
            runSpacing: 1.w, // Vertical space between lines
            children: List<Widget>.generate(
              _categories.length,
              (int index) {
                return ChoiceChip(
                  label: Text(
                    _categories[index],
                    style: kMedium14,
                  ),
                  selected: _selectedChipIndex == index,
                  selectedColor: Colors.blue,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedChipIndex = selected ? index : 0;
                      widget
                          .onCategorySelected(_categories[_selectedChipIndex]);
                    });
                  },
                  labelStyle: TextStyle(
                    color: _selectedChipIndex == index
                        ? Colors.white
                        : Colors.purple,
                  ),
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(
                    side: BorderSide(width: 1.sp, color: Colors.blue),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
