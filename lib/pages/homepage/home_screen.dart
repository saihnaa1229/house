import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee1.dart';
import 'package:test_fire/pages/booking_screen.dart';
import 'package:test_fire/pages/employee/create_employee_screen.dart';
import 'package:test_fire/pages/homepage/all_services.dart';
import 'package:test_fire/pages/user_profile_screen.dart';
import 'package:test_fire/services/employee_services.dart';
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/util/user.dart';
import 'package:test_fire/widgets/banner.dart';
import 'package:test_fire/widgets/employee_card.dart';
import 'package:test_fire/widgets/employee_container.dart';
import 'package:test_fire/widgets/services_item_card.dart';
import 'package:test_fire/widgets/services_item_container.dart';

import '../../util/utils.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/bottom_navigation_item.dart';
import '../admin_profile_scree.dart';
import '../employee_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomBarIndex = 0;
  int _selectedChipIndex = 0;
  List<String> _carouselItems = HomeServices.getCarouselItems();
  List<ServiceItemCard> _servicesItems = HomeServices.getServiceItems();
  Future<List<EmployeeCard>>? _employees;
  List<String> _categories = HomeServices.getServicesList();
  String? userRole;
  Future<void> loadData() async {
    _employees = homeServices.getAllEmployees();
    userRole = UserPreferences.getUserRole();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100.w, 14.h),
          child: HomeAppBar(),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(5.w, 2.w, 5.w, 5.w),
              child: Column(
                children: [
                  SearchTextField(),
                  CategoryText('Урамшуулал', 'Бүгдийг харах', () {}),
                  BannerSlider(
                    carouselItems: _carouselItems,
                  ),
                  CategoryText('Үйлчилгээ', 'Бүгдийг харах', () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllServices()));
                  }),
                  ServicesItemContainer(
                    serviesItems: _servicesItems,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.w),
                    child: Divider(
                      height: 2.sp,
                      thickness: 2.sp,
                      color: kTextFieldColor,
                    ),
                  ),
                  CategoryText('Эрэлттэй үйлчилгээ', 'Бүгдийг харах', () {}),
                  CategorySelect(),
                  SizedBox(
                    height: 5.w,
                  ),
                  FutureBuilder<List<EmployeeCard>>(
                    future: _employees,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.hasData) {
                        List<EmployeeCard> _employees = snapshot.data!;
                        return SingleChildScrollView(
                          child: EmployeeContainer(
                            employee: _employees,
                          ),
                        );
                      } else {
                        return Text("No products found");
                      }
                    },
                  ),
                ],
              )),
        ),
        bottomNavigationBar: BottomNavigation(
          activeColor: kPrimaryColor,
          index: bottomBarIndex,
          children: [
            BottomNavigationItem(
                iconText: 'Нүүр',
                icon: Icon(Icons.storefront),
                iconSize: 22.sp,
                onPressed: () {}),
            BottomNavigationItem(
              iconText: 'Захиалга',
              icon: Icon(Icons.manage_search_rounded),
              iconSize: 22.sp,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookingScreen()));
              },
            ),
            BottomNavigationItem(
              iconText: 'Календарь',
              icon: Icon(Icons.shopping_cart_outlined),
              iconSize: 22.sp,
              onPressed: () async {
                homeServices.addEmployee();
              },
            ),
            BottomNavigationItem(
              iconText: 'Мэдэгдэл',
              icon: Icon(Icons.favorite_border_rounded),
              iconSize: 22.sp,
              onPressed: () async {
                homeServices.employeesByCategory();
                print('done');
              },
            ),
            BottomNavigationItem(
              iconText: 'Профайл',
              icon: Icon(Icons.account_circle_outlined),
              iconSize: 22.sp,
              onPressed: () {
                switch (userRole) {
                  case 'admin':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminProfileScreen()),
                    );
                    break;
                  case 'employee':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeProfileScreen()),
                    );
                    break;
                  case 'user':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen()),
                    );
                    break;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Container CategorySelect() {
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
                    _selectedChipIndex == index ? Colors.white : Colors.purple,
              ),
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                  side: BorderSide(width: 2.sp, color: Colors.blue)),
            ),
          );
        },
      ),
    );
  }

  Container CategoryText(String first, String second, Function onPressed) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: kbold18,
          ),
          GestureDetector(
            onTap: () {
              onPressed();
            },
            child: Text(
              second,
              style: kMediumBlue12,
            ),
          )
        ],
      ),
    );
  }

  Container SearchTextField() {
    return Container(
      height: 8.h,
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: kHomeScreenHintText,
          hintStyle: kHomeScreenHintTextStyle,
          filled: true,
          fillColor: kTextFieldColor,
          prefixIcon: Padding(
            padding: EdgeInsets.all(2.5.w),
            child: Icon(FontAwesomeIcons.magnifyingGlass),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.all(2.5.w),
            child: Icon(
              FontAwesomeIcons.filter,
              color: kPrimaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.w),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Container HomeAppBar() {
    return Container(
      padding: EdgeInsets.all(5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/profile.webp',
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Бямбаа',
                    style: kHintRegular12,
                  ),
                  Text(
                    'Бямбацэрэн',
                    style: kSemibold16,
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.bell,
                size: 7.w,
                color: kHintTextColor,
              ),
              SizedBox(
                width: 3.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateEmployee()));
                },
                child: Icon(
                  Icons.bookmark_border,
                  size: 7.w,
                  color: kHintTextColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
