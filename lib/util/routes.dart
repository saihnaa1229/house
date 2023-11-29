import 'package:flutter/material.dart';
import 'package:test_fire/pages/employee/get_employee_information.dart';
import 'package:test_fire/pages/get_user_information.dart';
import 'package:test_fire/pages/homepage/home_screen.dart';

import '../pages/employee/about_employee.dart';
import '../pages/employee/employee_work_images.dart';

enum RouteNames {
  HomeScreen,
  GetUserInformation,
  GetEmployeeInformation,
  AboutEmployee,
  AddWorkImages,
  EmployeeScreen
}

extension RouteExtension on RouteNames {
  String get route {
    switch (this) {
      case RouteNames.HomeScreen:
        return 'HomeScreen';
      case RouteNames.GetUserInformation:
        return 'GetUserInformation';
      case RouteNames.GetEmployeeInformation:
        return 'GetEmployeeInformation';
      case RouteNames.AboutEmployee:
        return 'AboutEmployee';
      case RouteNames.AddWorkImages:
        return 'AddWorkImages';
      case RouteNames.EmployeeScreen:
        return 'EmployeeScreen';
    }
  }
}

var routes = <String, WidgetBuilder>{
  RouteNames.AboutEmployee.route: (_) => AboutEmployee(),
  RouteNames.HomeScreen.route: (_) => HomeScreen(),
  RouteNames.GetUserInformation.route: (_) => GetUserInformation(),
  RouteNames.GetEmployeeInformation.route: (_) => GetEmployeeInformation(),
  RouteNames.AddWorkImages.route: (_) => AddWorkImages(),
  // RouteNames.EmployeeScreen.route: (_) => EmployeeScreen(),
};
