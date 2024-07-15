import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../presentation/flights/search_flight/controller/search_flight_controller.dart';
import '../constants/image_constant.dart';
import '../font_helper/font_helper.dart';

flightClassBottomSheet(SearchFlightController controller, {Function()? onTap}) {
  Get.bottomSheet(
    GetBuilder<SearchFlightController>(
      init: controller,
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: 8.h, left: 15.h, right: 15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Class',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontFamily: FontHelper.boldFont,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: controller.flightClassList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.onTapClassItems(index);
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            controller.flightClassList[index].isSelected ==
                                    false
                                ? Image.asset(
                                    ImageConstant.unselectedIcon,
                                    fit: BoxFit.contain,
                                    height: 18.h,
                                    width: 18.w,
                                  )
                                : Image.asset(
                                    ImageConstant.selectedIcon,
                                    fit: BoxFit.contain,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              controller.flightClassList[index].text ?? '',
                              // 'Paradise Resort',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontFamily: FontHelper.boldFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

flightDetailsBottomSheet({
  String? originLocation,
  String? destinationLocation,
  String? originItaCode,
  String? destinationItaCode,
  String? airLineName,
  String? duration,
  String? departureDate,
  String? arriveDate,
  String? departureTime,
  String? arriveTime,
  String? classType,
  String? carryBagCount,
  String? checkedBagCount,
}) {
  return Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 15.h, right: 15.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Flight Details',
                            // 'Paradise Resort',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontFamily: FontHelper.boldFont,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              originLocation ?? '',
                              overflow: TextOverflow.ellipsis,
                              // 'Paradise Resort',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                                fontFamily: FontHelper.semiBoldFont,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Flexible(
                            child: Text(
                              destinationLocation ?? '',
                              overflow: TextOverflow.ellipsis,
                              // 'Paradise Resort',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                                fontFamily: FontHelper.semiBoldFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, left: 15.h, right: 15.w),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 15.h, right: 15.w),
                      height: Get.height * 0.27,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Overview',
                                // 'Paradise Resort',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontFamily: FontHelper.boldFont,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        originItaCode ?? '',
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_sharp,
                                        size: 16.sp,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        destinationItaCode ?? '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'AA10',
                                    // 'Paradise Resort',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.semiBoldFont,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 120.h,
                                width: 20.w,
                                child: Image.asset(
                                  ImageConstant.flightDetailsIcon,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: Get.height * 0.18,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            originLocation ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            // 'Paradise Resort',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontFamily: FontHelper.boldFont,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                departureDate ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                // 'Paradise Resort',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      FontHelper.boldFont,
                                                ),
                                              ),
                                              Text(
                                                departureTime ?? '',
                                                // 'Paradise Resort',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.grey,
                                                  fontFamily:
                                                      FontHelper.semiBoldFont,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            airLineName ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            // 'Paradise Resort',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.blue,
                                              fontFamily: FontHelper.boldFont,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Non Stop',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.blue,
                                                    fontFamily: FontHelper
                                                        .semiBoldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                                Image.asset(
                                                  ImageConstant
                                                      .forwardDottedLineIcon,
                                                  fit: BoxFit.contain,
                                                  width: Get.width * 0.2,
                                                ),
                                                Text(
                                                  duration ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.black,
                                                    fontFamily: FontHelper
                                                        .semiBoldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            classType ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            // 'Paradise Resort',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.blue,
                                              fontFamily: FontHelper.boldFont,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            destinationLocation ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            // 'Paradise Resort',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontFamily: FontHelper.boldFont,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                arriveDate ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                // 'Paradise Resort',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontFamily:
                                                      FontHelper.boldFont,
                                                ),
                                              ),
                                              Text(
                                                arriveTime ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                // 'Paradise Resort',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.grey,
                                                  fontFamily:
                                                      FontHelper.semiBoldFont,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: Get.height * 0.2,
                          width: Get.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstant.carryBagTwo,
                                height: 100.h,
                                width: 250.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageConstant.carryBagLogoOne,
                                    height: 10.h,
                                    width: 10.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '$carryBagCount Carry-on bag',
                                    // 'Paradise Resort',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.semiBoldFont,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: Get.height * 0.2,
                          width: Get.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageConstant.carryBagOne,
                                height: 100.h,
                                width: 250.w,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageConstant.carryBagLogoTwo,
                                    height: 10.h,
                                    width: 10.w,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    '$checkedBagCount Checked bag',
                                    // 'Paradise Resort',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.semiBoldFont,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

flightTravellersBottomSheet(
  SearchFlightController controller, {
  VoidCallback? onTapDone,
  Function(String)? onTapAdults,
  Function(String)? onTapChildren,
}) {
  Get.bottomSheet(
    GetBuilder<SearchFlightController>(
      init: controller,
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: 10.h, left: 15.h, right: 15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No. of Travellers',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontFamily: FontHelper.boldFont,
                    ),
                  ),
                  TextButton(
                    onPressed: onTapDone,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        fontFamily: FontHelper.boldFont,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonCountWidget(
                        titleText: 'Adults',
                        selectedIndex: controller.selectedAdultIndex,
                        onTap: (v) {
                          onTapAdults != null ? onTapAdults(v) : null;
                          controller.update();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      commonCountWidget(
                        titleText: 'Children',
                        selectedIndex: controller.selectedChildrenIndex,
                        onTap: (v) {
                          onTapChildren != null ? onTapChildren(v) : null;
                          controller.update();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.childrenAgeList.isNotEmpty,
                          child: Flexible(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.childrenAgeList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    flightCountBottomSheet(
                                      onTap: (count) {
                                        controller.updateChildrenAge(
                                          index,
                                          count.toString(),
                                        );
                                      },
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(
                                        'Age of Children (${index + 1})',
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        height: 45.h,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.childrenAgeList[index]
                                                          .age
                                                          .toString() !=
                                                      'null'
                                                  ? controller
                                                      .childrenAgeList[index]
                                                      .age
                                                      .toString()
                                                  : '',
                                              // 'Paradise Resort',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                                fontFamily: FontHelper.boldFont,
                                              ),
                                            ),
                                            Image.asset(
                                              ImageConstant.downArrow,
                                              height: 10.h,
                                              width: 10.w,
                                              fit: BoxFit.contain,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      controller.selectedChildrenIndex.value > 0
                          ? Flexible(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Note:',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "A child's age must be valid for the full duration of journey. For example, if a child has a birthday during a trip please use their age on the date of the returning flight.",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontFamily: FontHelper.semiBoldFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget commonCountWidget({
  String? titleText,
  Function(String)? onTap,
  RxInt? selectedIndex,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontFamily: FontHelper.boldFont,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Visibility(
            visible: titleText == 'Adults',
            child: Text(
              '(12+ Yrs)',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: FontHelper.treatmentFont,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 5.h,
      ),
      SizedBox(
        height: 30.h,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 8,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                () => InkWell(
                  onTap: () {
                    onTap != null
                        ? onTap(
                            titleText == 'Children' ? '$index' : '${index + 1}')
                        : null;
                    selectedIndex?.value = index;
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 11.w),
                    decoration: BoxDecoration(
                        color: selectedIndex?.value == index
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: selectedIndex?.value == index
                              ? Colors.blue
                              : Colors.grey,
                        )),
                    child: Center(
                      child: Text(
                        titleText == 'Children' ? '$index' : '${index + 1}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: selectedIndex?.value == index
                              ? Colors.white
                              : Colors.black,
                          fontFamily: FontHelper.boldFont,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    ],
  );
}

String dateFormat(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String dateFormatString(String date) {
  log(date.toString());
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String convertTime(String time) {
  DateTime dateTime = DateTime.parse(time);
  return DateFormat('hh:mm a').format(dateTime);
}

flightCountBottomSheet({Function(int)? onTap}) {
  return Get.bottomSheet(
    Container(
      padding: EdgeInsets.only(top: 10.h, left: 15.h, right: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(5.0.r),
                child: Icon(
                  Icons.close,
                  size: 25.sp,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 13,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    onTap != null
                        ? onTap(
                            index,
                          )
                        : null;
                    Get.back();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      index == 13 ? const SizedBox() : const Divider(),
                      Container(
                        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                        child: Text(
                          '$index',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: FontHelper.treatmentFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
