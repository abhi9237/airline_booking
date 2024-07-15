import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_button/common_button.dart';
import '../../../../core/common_text_form_filled/common_text_form_filled.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/constants/image_constant.dart';
import '../../../../core/font_helper/font_helper.dart';
import '../controller/search_flight_controller.dart';

class SearchFlightScreen extends StatelessWidget {
  const SearchFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SearchFlightController>(
        init: SearchFlightController(),
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Container(
                    height: Get.height * 0.45,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          18.r,
                        ),
                        bottomLeft: Radius.circular(18.r),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 15.w,
                    right: 15.w,
                    child: SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello james,',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                  Text(
                                    'Where to go?',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                ],
                              ),
                              // Container(
                              //   height: 50.h,
                              //   width: 50.w,
                              //   decoration: const BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //       image:
                              //           AssetImage(ImageConstant.dummyManImg),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.h,
                              horizontal: 10.w,
                            ),
                            height: Get.height * 0.6,
                            width: Get.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.isOneWaySelected.value =
                                            true;
                                        controller.update();
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 5.h,
                                          bottom: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller
                                                  .isOneWaySelected.value
                                              ? Colors.blue
                                              : Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ), // Add border for contrast
                                        ),
                                        child: Text(
                                          'One Way',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: controller
                                                    .isOneWaySelected.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: FontHelper
                                                .boldFont, // Replace with your FontHelper
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.isOneWaySelected.value =
                                            false;
                                        controller.update();
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                          left: 18.w,
                                          right: 18.w,
                                          top: 5.h,
                                          bottom: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              controller.isOneWaySelected.value
                                                  ? Colors.grey.withOpacity(0.5)
                                                  : Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Text(
                                          'Round Trip',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: controller
                                                    .isOneWaySelected.value
                                                ? Colors.black
                                                : Colors.white,
                                            fontFamily: FontHelper
                                                .boldFont, // Replace with your FontHelper
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 150.h,
                                  width: Get.width,
                                  child: Stack(
                                    children: [
                                      CommonFlightTextFormFilled(
                                        controller:
                                            controller.originController.value,
                                        suggestionList: controller
                                            .airPortSuggestionList.value,
                                        labelText: 'From',
                                        hintText: 'Origin',
                                        airportLocation: controller
                                            .originAirportLocation.value,
                                        flightIcon:
                                            ImageConstant.flightTakeOffIcon,
                                        onSearchTextChanged: (v) {
                                          if (v.isNotEmpty) {
                                            controller.getPlacesData(v);
                                          } else {
                                            Future.delayed(
                                              const Duration(
                                                milliseconds: 900,
                                              ),
                                            ).then((value) {
                                              controller.airPortSuggestionList
                                                  .clear();
                                              controller.airPortSuggestionList
                                                  .refresh();
                                              controller.update();
                                            });
                                          }
                                        },
                                        onTap: () {
                                          controller.airPortSuggestionList
                                              .clear();
                                          controller.airPortSuggestionList
                                              .refresh();
                                          controller.update();
                                        },
                                        onSuggestionTap: (data) {
                                          controller.onTapOriginSuggestion(
                                              location: data.item?.iataCityCode,
                                              name: data.item?.name,
                                              cityName: data.item?.cityName,
                                              cityCode:
                                                  data.item?.iataCityCode);
                                        },
                                      ),
                                      Positioned(
                                        top: 75.h,
                                        left: 0,
                                        right: 0,
                                        child: CommonFlightTextFormFilled(
                                          controller: controller
                                              .destinationController.value,
                                          suggestionList: controller
                                              .airPortSuggestionList.value,
                                          labelText: 'To',
                                          hintText: 'Destination',
                                          airportLocation: controller
                                              .destinationAirportLocation.value,
                                          flightIcon:
                                              ImageConstant.flightLandIcon,
                                          onSearchTextChanged: (v) {
                                            if (v.isNotEmpty) {
                                              controller.getPlacesData(v);
                                            } else {
                                              Future.delayed(
                                                const Duration(seconds: 1),
                                              ).then((value) {
                                                controller.airPortSuggestionList
                                                    .clear();
                                                controller.airPortSuggestionList
                                                    .refresh();
                                                controller.update();
                                              });
                                            }
                                          },
                                          onSuggestionTap: (data) {
                                            controller
                                                .onTapDestinationSuggestion(
                                                    location:
                                                        data.item?.iataCityCode,
                                                    name: data.item?.name,
                                                    cityName:
                                                        data.item?.cityName,
                                                    cityCode: data
                                                        .item?.iataCityCode);
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        right: 30.w,
                                        top: 35.h,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: 8.w,
                                            right: 8.w,
                                          ),
                                          height: 55.h,
                                          width: 55.w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                ImageConstant.flightUpArrowIcon,
                                                height: 22.h,
                                                width: 18.w,
                                                fit: BoxFit.cover,
                                              ),
                                              Image.asset(
                                                ImageConstant
                                                    .flightDownArrowIcon,
                                                fit: BoxFit.cover,
                                                height: 22.h,
                                                width: 18.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SelectDateTimeWidget(
                                      selectedText:
                                          controller.departureDate.value,
                                      titleText: 'Depart Date',
                                      onTap: () {
                                        controller.selectDate(
                                          context,
                                          type: 'depart',
                                        );
                                      },
                                    ),
                                    controller.isOneWaySelected.value == false
                                        ? SelectDateTimeWidget(
                                            selectedText:
                                                controller.returnDate.value,
                                            titleText: 'Return Date',
                                            onTap: () {
                                              controller.selectDate(
                                                context,
                                                type: 'return',
                                              );
                                            },
                                          )
                                        : RoundTripWidget(
                                            selectedText:
                                                controller.returnDate.value,
                                            titleText: 'Return Date',
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SelectDateTimeWidget(
                                      onTap: () {
                                        flightTravellersBottomSheet(
                                          controller,
                                          onTapDone: () {
                                            controller.onTapDoneTravellers();
                                          },
                                          onTapAdults: (v) {
                                            controller
                                                .onTapAdults(int.parse(v));
                                          },
                                          onTapChildren: (v) {
                                            controller
                                                .onTapChildren(int.parse(v));
                                          },
                                        );
                                      },
                                      selectedText:
                                          '${controller.totalTravelers.value} Traveller',
                                      titleText: 'Traveller(S)',
                                    ),
                                    SelectDateTimeWidget(
                                      onTap: () {
                                        flightClassBottomSheet(controller);
                                      },
                                      selectedText: controller.classValue.value,
                                      titleText: 'Class',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                HotelFlightCommonButton(
                                  isLoading: controller.isLoading,
                                  buttonText: 'Search',
                                  onTap: () {
                                    controller.onTapSearch();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectDateTimeWidget extends StatelessWidget {
  final String? titleText;
  final String? selectedText;
  final VoidCallback? onTap;
  const SelectDateTimeWidget({
    super.key,
    this.titleText,
    this.selectedText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.blue.withOpacity(0.2),
          border: Border.all(color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue,
                fontFamily: FontHelper.semiBoldFont,
              ),
            ),
            Text(
              selectedText ?? '',
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
  }
}

class RoundTripWidget extends StatelessWidget {
  final String? titleText;
  final String? selectedText;
  final VoidCallback? onTap;
  const RoundTripWidget({
    super.key,
    this.titleText,
    this.selectedText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.blue.withOpacity(0.2),
          border: Border.all(color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue,
                fontFamily: FontHelper.semiBoldFont,
              ),
            ),
            Text(
              selectedText ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
                fontFamily: FontHelper.boldFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
