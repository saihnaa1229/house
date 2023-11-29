// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/widgets/app_bar.dart';

import '../../services/home_service.dart';
import '../../widgets/services_item_card.dart';
import '../../widgets/services_item_container.dart';

class AllServices extends StatelessWidget {
  List<ServiceItemCard> _servicesItems = HomeServices.getAllServiceItems();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBarWithImage(
            leadIcon: Icons.arrow_back_rounded,
            leadIconFuncion: () {
              Navigator.of(context).pop();
            },
            text: 'Төрөл',
            suffixIcon2: FontAwesomeIcons.ellipsis,
          ),
          preferredSize: Size(100.w, 15.h),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 5.w),
          child: ServicesItemContainer(
            serviesItems: _servicesItems,
          ),
        ),
      ),
    );
  }
}
