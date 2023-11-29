import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:test_fire/model/employee.dart';
import 'package:test_fire/model/employee1.dart';

import '../../util/constants.dart';
import '../../util/constants.dart';

class EmployeeScreen extends StatefulWidget {
  final Employee1 employee;
  EmployeeScreen({super.key, required this.employee});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  bool isExpanded = false;
  int _selectedChipIndex = 0;

  List<String> _categories = ['All', '5', '4', '3', '2', '1'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 40.h),
        child: Stack(
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                widget.employee.url,
                height: 40.h,
                width: 100.w,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.w, 10.w, 0.w, 0.w),
              child: IconButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 25.sp,
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.employee.category,
                    style: kbold18,
                  ),
                  Icon(
                    Icons.bookmark_border_rounded,
                    size: 20.sp,
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    widget.employee.fullName,
                    style: kMediumBlue14,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(Icons.star, color: Colors.yellow[600], size: 20),
                  SizedBox(width: 2.w),
                  Text(
                    '${widget.employee.rating}   |',
                    style: kRegular12,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    '${widget.employee.review}',
                    style: kRegular12,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                    child: Text(
                      'Цэвэрлэгээ',
                      style: kMediumBlue12,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Icon(Icons.location_on, color: kPrimaryColor, size: 20),
                  SizedBox(width: 1.5.w),
                  Text(
                    'Баян бүрд',
                    style: kRegular12,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    '₮${widget.employee.salary} ',
                    style: kSemiboldBlue16,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '(Цалин)',
                    style: kRegular12,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Миний тухай",
                style: kSemibold16,
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                child: ReadMoreText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Үргэлжлүүлэх',
                  trimExpandedText: 'Багасгах',
                  lessStyle: kMediumBlue12,
                  moreStyle: kMediumBlue12,
                  style: kRegular12,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Зураг',
                    style: kSemibold16,
                  ),
                  Text(
                    'Бүгдийг харах',
                    style: kMediumBlue12,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                child: Wrap(
                  spacing: 2.w,
                  runSpacing: 2.w,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w)),
                      clipBehavior: Clip.hardEdge,
                      width: 40.w,
                      child: Image.network(
                        'https://www.oninstaffing.com/wp-content/uploads/2019/09/hotel_housekeeper_job.jpg',
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w)),
                      clipBehavior: Clip.hardEdge,
                      width: 40.w,
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSszDm8U2Mbogt2yUJJ0V0OmmBhPbmLO5UFMnHzMkYuV1MNtWYYb2l4U0A90UfAfVgnF_Q&usqp=CAU'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w)),
                      clipBehavior: Clip.hardEdge,
                      width: 50.w,
                      child: Image.network(
                          'https://www.caterer.com/advice/wp-content/uploads/housekeeper-job-description.jpg'),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w)),
                        clipBehavior: Clip.hardEdge,
                        width: 30.w,
                        child: Image.network(
                            'https://www.ziprecruiter.com/svc/fotomat/public-ziprecruiter/uploads/job_description_template/Hotel_Housekeeper.jpg'))
                  ],
                ),
              ),
              Container(
                height: 8.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: ChoiceChip(
                        label: Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: _selectedChipIndex == index
                                  ? Colors.white
                                  : kPrimaryColor,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              _categories[index],
                              style: kRegular12,
                            ),
                          ],
                        ),
                        selected: _selectedChipIndex == index,
                        selectedColor: kPrimaryColor,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedChipIndex = selected ? index : 0;
                          });
                        },
                        labelStyle: TextStyle(
                          color: _selectedChipIndex == index
                              ? Colors.white
                              : kPrimaryColor,
                        ),
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(
                            side:
                                BorderSide(width: 2.sp, color: kPrimaryColor)),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.w)),
                              clipBehavior: Clip.hardEdge,
                              height: 14.w,
                              width: 14.w,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                    'https://www.perfocal.com/blog/content/images/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg'),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              'LAURESS',
                              style: kSemibold14,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5.w),
                              padding: EdgeInsets.fromLTRB(3.w, 1.w, 3.w, 1.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.w),
                                border: Border.all(
                                    width: 2.sp, color: kPrimaryColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    '5',
                                    style: kRegular12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3.w),
                      child: Text(
                        'amazingamazingamazingamazin gamazingamazingamazingam azingamazingamazingamazingamazingamazing',
                        style: kRegular12,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: kPrimaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '16',
                          style: kRegular12,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '2 weeks ago',
                          style: kRegular10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.w)),
                              clipBehavior: Clip.hardEdge,
                              height: 14.w,
                              width: 14.w,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                    'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              'Eric',
                              style: kSemibold14,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5.w),
                              padding: EdgeInsets.fromLTRB(3.w, 1.w, 3.w, 1.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.w),
                                border: Border.all(
                                    width: 2.sp, color: kPrimaryColor),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    '4',
                                    style: kRegular12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3.w),
                      child: Text(
                        'Lorem Ipsum text Lorem Ipsum text Lorem Ipsum text Lorem Ipsum text Lorem Ipsum text Lorem Ipsum text',
                        style: kRegular12,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: kPrimaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '30',
                          style: kRegular12,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '3 weeks ago',
                          style: kRegular10,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
