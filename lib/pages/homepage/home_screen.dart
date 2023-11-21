import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/user.dart';
import 'package:test_fire/pages/booking_screen.dart';
import 'package:test_fire/pages/homepage/all_services.dart';
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/util/constants.dart';
import 'package:test_fire/widgets/banner.dart';
import 'package:test_fire/widgets/employee_card.dart';
import 'package:test_fire/widgets/employee_container.dart';
import 'package:test_fire/widgets/services_item_card.dart';
import 'package:test_fire/widgets/services_item_container.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/bottom_navigation_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temp = HomeServices.getUserDetail();
  int bottomBarIndex = 0;
  int _selectedChipIndex = 0;
  List<String> _carouselItems = HomeServices.getCarouselItems();
  List<ServiceItemCard> _servicesItems = HomeServices.getServiceItems();
  List<EmployeeCard> _employeeItems = HomeServices.getEmployeeDetails();

  List<String> _categories = HomeServices.getServicesList();

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
                  CategoryText('Special offers', 'See all', () {}),
                  BannerSlider(
                    carouselItems: _carouselItems,
                  ),
                  CategoryText('Services', 'See all', () {
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
                  CategoryText('Most Popular Services', 'See all', () {}),
                  CategorySelect(),
                  SizedBox(
                    height: 5.w,
                  ),
                  EmployeeContainer(
                    employee: _employeeItems,
                  ),
                ],
              )),
        ),
        bottomNavigationBar: BottomNavigation(
          activeColor: kPrimaryColor,
          index: bottomBarIndex,
          children: [
            BottomNavigationItem(
                iconText: 'Home',
                icon: Icon(Icons.storefront),
                iconSize: 22.sp,
                onPressed: () {}),
            BottomNavigationItem(
              iconText: 'Bookings',
              icon: Icon(Icons.manage_search_rounded),
              iconSize: 22.sp,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookingScreen()));
              },
            ),
            BottomNavigationItem(
              iconText: 'Calendar',
              icon: Icon(Icons.shopping_cart_outlined),
              iconSize: 22.sp,
              onPressed: () {},
            ),
            BottomNavigationItem(
              iconText: 'inbox',
              icon: Icon(Icons.favorite_border_rounded),
              iconSize: 22.sp,
              onPressed: () {},
            ),
            BottomNavigationItem(
              iconText: 'Profile',
              icon: Icon(Icons.account_circle_outlined),
              iconSize: 22.sp,
              onPressed: () {
                print("5");
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
                  temp.img,
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
                    'Good Morning',
                    style: kHintRegular12,
                  ),
                  Text(
                    '${temp.fullname} ${temp.username}',
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
              Icon(
                Icons.bookmark_border,
                size: 7.w,
                color: kHintTextColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
