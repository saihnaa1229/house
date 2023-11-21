import 'package:flutter/material.dart';
import 'package:test_fire/model/booking.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/widgets/employee_card.dart';

import '../model/services.dart';
import '../model/user.dart';
import '../widgets/booking_item_card.dart';
import '../widgets/services_item_card.dart';

class HomeServices {
  static User getUserDetail() {
    return User(
        userId: 0,
        img: 'assets/images/profile.webp',
        address: 'address',
        birth: 'birth',
        email: 'email',
        fullname: 'fullname',
        number: 'number',
        username: 'username');
  }

  static List<String> getCarouselItems() {
    List<String> temp = [];
    temp.add(
        'https://www.shutterstock.com/image-photo/basket-bucket-cleaning-items-on-260nw-1154607223.jpg');
    temp.add(
        'https://previews.123rf.com/images/wdnet/wdnet1806/wdnet180600047/105364144-healthy-eating-and-green-grocery-shopping-banner-group-of-selected-fresh-vegetables-on-abstract.jpg');
    temp.add(
        'https://media.istockphoto.com/id/1071027802/photo/fresh-vegetables-on-blurred-abstract-background.jpg?s=612x612&w=is&k=20&c=utwrb5kR74kTACb1sOLHp3RaY3AtzKLgoYw1EIelC48=');
    return temp;
  }

  static List<String> getServicesList() {
    List<String> temp = ['All', 'Cleaning', 'Repairing', 'Painting'];
    return temp;
  }

  static List<String> getBookingStatus() {
    List<String> temp = ['Upcoming', 'Completed', 'Selected'];

    return temp;
  }

  static List<ServiceItemCard> getServiceItems() {
    List<ServiceItemCard> temp = [];
    for (int i = 0; i < 8; i++) {
      temp.add(serviceListItems[i]);
    }
    return temp;
  }

  static List<ServiceItemCard> getAllServiceItems() {
    List<ServiceItemCard> temp = [];
    for (int i = 0; i < serviceListItems.length; i++) {
      temp.add(serviceListItems[i]);
    }
    return temp;
  }

  static List<EmployeeCard> getEmployeeDetails() {
    List<EmployeeCard> temp = [];
    for (int i = 0; i < employeeLists.length; i++) {
      temp.add(employeeLists[i]);
    }
    return temp;
  }

  List<BookingItemCard> getBookingDetails(int index) {
    List<BookingItemCard> temp = [];

    for (int i = 0; i < bookingList.length; i++) {
      if (bookingList[i].bookingitems.status == index) {
        temp.add(bookingList[i]);
      }
    }
    return temp;
  }
}

List<EmployeeCard> employeeLists = [
  EmployeeCard(
    employee: Employee(
        name: 'Saihnaa',
        category: 'House Cleaning',
        employeeId: 0,
        img: 'assets/images/profile.webp',
        rating: 4.8,
        review: 841,
        salary: 25),
  ),
  EmployeeCard(
    employee: Employee(
        name: 'Byambaa',
        category: 'House Cleaning',
        employeeId: 0,
        img: 'assets/images/profile.webp',
        rating: 4.8,
        review: 841,
        salary: 25),
  ),
  EmployeeCard(
    employee: Employee(
        name: 'Ariuka',
        category: 'House Cleaning',
        employeeId: 0,
        img: 'assets/images/profile.webp',
        rating: 4.8,
        review: 841,
        salary: 25),
  ),
  EmployeeCard(
    employee: Employee(
        name: 'Anujin',
        category: 'House Cleaning',
        employeeId: 0,
        img: 'assets/images/profile.webp',
        rating: 4.8,
        review: 841,
        salary: 25),
  ),
  EmployeeCard(
    employee: Employee(
        name: 'Saraa',
        category: 'House Cleaning',
        employeeId: 0,
        img: 'assets/images/profile.webp',
        rating: 4.8,
        review: 841,
        salary: 25),
  ),
];

List<ServiceItemCard> serviceListItems = [
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff7210ff), icon: Icons.favorite, name: 'Cleaning'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffEA10AC), icon: Icons.favorite, name: 'Repairing'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff1A96F0), icon: Icons.favorite, name: 'Painting'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffFFCD29), icon: Icons.favorite, name: 'Laundry'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffF54336), icon: Icons.favorite, name: 'Appliance'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff4AAF57), icon: Icons.favorite, name: 'Plumbing'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff00BCD3), icon: Icons.favorite, name: 'Shifting'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff9953FF), icon: Icons.favorite, name: 'Beauty'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff14AE5C), icon: Icons.favorite, name: 'AC Repaet'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff007BE5), icon: Icons.favorite, name: 'Vehicle'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffF54C40), icon: Icons.favorite, name: 'Electronics'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xffCC0100), icon: Icons.favorite, name: 'Massage'),
  ),
  ServiceItemCard(
    serviceItem: ServiceItem(
        color: Color(0xff9747FF), icon: Icons.favorite, name: 'Men'),
  ),
];

List<BookingItemCard> bookingList = [
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Saihnaa',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 0),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Saraa',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 0),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Anujin',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 1),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Byambaa',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 2),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Ariuka',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 2),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Zaya',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 1),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Amraa',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 0),
  ),
  BookingItemCard(
    bookingitems: Booking(
        employee: Employee(
            name: 'Erdene',
            category: 'House Cleaning',
            employeeId: 0,
            img: 'assets/images/profile.webp',
            rating: 4.8,
            review: 841,
            salary: 25),
        bookingId: 0,
        status: 0),
  )
];

// final List<String> _categories = ['All', 'Cleaning', 'Repairing', 'Painting'];

// final List<String> _bookingStatus = ['Upcoming', 'Completed', 'Selected'];
