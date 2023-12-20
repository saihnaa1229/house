import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/widgets/booking_item_card.dart';

class BookingItemCardContainer extends StatelessWidget {
  final List<BookingItemCard> bookingItem;

  BookingItemCardContainer({
    required this.bookingItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Wrap(spacing: 5.5.w, runSpacing: 4.w, children: bookingItem),
    );
  }
}
