import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/services/home_service.dart';
import 'package:test_fire/widgets/app_bar.dart';
import 'package:test_fire/widgets/custom_app_bar.dart';
import 'package:test_fire/widgets/custom_text_button.dart';

import '../util/constants.dart';
import '../widgets/booking_item_card.dart';
import '../widgets/booking_item_card_container.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/bottom_navigation_item.dart';
import '../widgets/services_item_card.dart';
import '../widgets/services_item_container.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({super.key});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // int topItemIndex = 0;
  int _selectedChipIndex = 1;
  List<BookingItemCard>? _bookingItemCards;
  int bottomBarIndex = 1;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    HomeServices homeServices = HomeServices();
    _bookingItemCards = homeServices.getBookingDetails(_selectedChipIndex);
    _bookingItemCards = (bottomBarIndex == 1)
        ? await homeServices.getBookingDetails(_selectedChipIndex)
        : await null;
  }

  List<String> _bookingStatus = HomeServices.getBookingStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBarWithImage(
              img: 'assets/images/profile.webp',
              suffixIcon1: FontAwesomeIcons.magnifyingGlass,
              suffixIcon2: FontAwesomeIcons.ellipsis,
              text: 'Миний захиалга'),
          preferredSize: Size(100.w, 15.h),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CategorySelect(),
                _bookingItemCards == null
                    ? Container()
                    : BookingItemCardContainer(
                        bookingItem: _bookingItemCards!,
                      )

          
              ],
            ),
          ),
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
              onPressed: () {},
            ),
            BottomNavigationItem(
              iconText: 'Календар',
              icon: Icon(Icons.shopping_cart_outlined),
              iconSize: 22.sp,
              onPressed: () {},
            ),
            BottomNavigationItem(
              iconText: 'Мэдэгдэл',
              icon: Icon(Icons.favorite_border_rounded),
              iconSize: 22.sp,
              onPressed: () {},
            ),
            BottomNavigationItem(
              iconText: 'Профайл',
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
        itemCount: _bookingStatus.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedChipIndex == index;
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                  _selectedChipIndex = index;
                  isSelected = _selectedChipIndex == index;
                  loadData();
                },
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: isSelected ? 3.sp : 1.sp,
                          color: isSelected ? kPrimaryColor : Colors.grey),
                    ),
                  ),
                  child: Text(_bookingStatus[index],
                      style: isSelected ? kSemiboldBlue16 : kRegularHint14),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
