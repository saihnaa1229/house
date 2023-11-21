import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'services_item_card.dart';

class ServicesItemContainer extends StatelessWidget {
  final List<ServiceItemCard> serviesItems;

  ServicesItemContainer({
    required this.serviesItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Wrap(spacing: 3.w, runSpacing: 8.w, children: serviesItems),
    );
  }
}
