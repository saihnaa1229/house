// ignore_for_file: override_on_non_overriding_member

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../util/constants.dart';

class BannerSlider extends StatefulWidget {
  final List<String> carouselItems;

  BannerSlider({required this.carouselItems});

  @override
  State<StatefulWidget> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  int activeIndex = 0;

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.w),
          ),
          clipBehavior: Clip.hardEdge,
          child: CarouselSlider.builder(
            itemCount: widget.carouselItems.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return buildBanner(widget.carouselItems[index], index);
            },
            options: CarouselOptions(
              // height: 15.h,
              autoPlayInterval: Duration(seconds: 5),
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildBanner(String carouselItem, int index) {
    return Container(
      width: double.infinity,
      child: Image.network(
        carouselItem,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildIndicator() {
    return Container(
      height: 18.h,
      padding: EdgeInsets.only(bottom: 1.h),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.carouselItems.length,
        effect: ExpandingDotsEffect(
          dotHeight: 1.5.h,
          dotWidth: 1.5.h,
          dotColor: kSearchHintTextColor,
          activeDotColor: kPrimaryColor,
        ),
      ),
    );
  }
}
