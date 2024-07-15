import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../core/constants/image_constant.dart';
import '../../../../core/font_helper/font_helper.dart';
import '../../modal/flight_detail_modal.dart';
import '../controller/seat_booking_controller.dart';
import '../modal/seat_modal.dart';

class SeatSelectionScreen extends StatelessWidget {
  final bool? isOneWaySelected;
  final Offers? bookingDetail;
  final RxList<Rows>? allRowList;
  final RxList<Rows>? allReturnRowList;
  final String? classType;
  final List<SeatSelection>? seatSelection;
  const SeatSelectionScreen({
    super.key,
    this.isOneWaySelected,
    this.bookingDetail,
    this.allReturnRowList,
    this.allRowList,
    this.seatSelection,
    this.classType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SeatBookingController>(
        init: SeatBookingController(
            seatSelection: seatSelection ?? [],
            offerId: bookingDetail?.id,
            isOneWayTripSelected: isOneWaySelected,
            passangerLength: bookingDetail?.passengers?.length,
            allReturnRowList: allReturnRowList,
            allRowList: allRowList),
        builder: (controller) {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Container(
                          height: isOneWaySelected == false
                              ? Get.height * 0.57
                              : Get.height * 0.34,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.r),
                              bottomRight: Radius.circular(15.r),
                            ),
                            color: Colors.blue,
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                height: 55.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0.5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Booking Details',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontFamily: FontHelper
                                            .boldFont, // Replace with your FontHelper
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              OneWayTripWidget(
                                onTap: () {
                                  // log('resuklt ');
                                  // controller.createSeatsList();
                                  // controller.firstSectionData();
                                },
                                onTapFlightDetails: () {
                                  controller.onTapFlightDetails(
                                      classType: classType,
                                      offer: bookingDetail,
                                      index: 0);
                                },
                                duration: bookingDetail
                                        ?.slices?[0].segments?[0].duration
                                        ?.replaceFirst('PT', '')
                                        .replaceFirst('P1DT', '')
                                        .replaceFirst('P2DT', '') ??
                                    '',
                                arriveTime: convertTime(
                                  bookingDetail?.slices?[0].segments?[0]
                                          .arrivingAt ??
                                      '',
                                ),
                                airLineName: bookingDetail?.owner?.name ?? '',
                                departDate: controller
                                    .formattedNullAbleStringDepartDateIndex(
                                  bookingDetail,
                                  0,
                                ),
                                price: bookingDetail?.baseAmount ?? '',
                                aitLineLogo:
                                    bookingDetail?.owner?.logoSymbolUrl ?? '',
                                arriveItaCode: bookingDetail
                                        ?.slices?[0].destination?.iataCode ??
                                    '',
                                departItaCode: bookingDetail
                                        ?.slices?[0].origin?.iataCode ??
                                    '',
                                departTime: convertTime(
                                  bookingDetail?.slices?[0].segments?[0]
                                          .departingAt ??
                                      '',
                                ),
                              ),
                              isOneWaySelected == false
                                  ? OneWayTripWidget(
                                      onTap: () {},
                                      onTapFlightDetails: () {
                                        controller.onTapFlightDetails(
                                            classType: classType,
                                            offer: bookingDetail,
                                            index: 1);
                                      },
                                      duration: bookingDetail
                                              ?.slices?[1].segments?[0].duration
                                              ?.replaceFirst('PT', '')
                                              .replaceFirst('P1DT', '')
                                              .replaceFirst('P2DT', '') ??
                                          '',
                                      arriveTime: convertTime(
                                        bookingDetail?.slices?[1].segments?[0]
                                                .arrivingAt ??
                                            '',
                                      ),
                                      airLineName:
                                          bookingDetail?.owner?.name ?? '',
                                      departDate: controller
                                          .formattedNullAbleStringDepartDateIndex(
                                        bookingDetail,
                                        1,
                                      ),
                                      price: bookingDetail?.baseAmount ?? '',
                                      aitLineLogo:
                                          bookingDetail?.owner?.logoSymbolUrl ??
                                              '',
                                      arriveItaCode: bookingDetail?.slices?[1]
                                              .destination?.iataCode ??
                                          '',
                                      departItaCode: bookingDetail
                                              ?.slices?[1].origin?.iataCode ??
                                          '',
                                      departTime: convertTime(
                                        bookingDetail?.slices?[1].segments?[0]
                                                .departingAt ??
                                            '',
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      isOneWaySelected == false
                          ? SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (controller.isSelectedTripType.value ==
                                          true) {
                                        controller.isSelectedTripType.value =
                                            false;
                                      }
                                      controller.update();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.only(top: 5.h, left: 15.w),
                                      width: 80.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: controller
                                                    .isSelectedTripType.value ==
                                                false
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      child: Text(
                                        '${bookingDetail?.slices?[0].origin?.iataCode ?? ''} - ${bookingDetail?.slices?[0].destination?.iataCode ?? ''}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: controller.isSelectedTripType
                                                      .value ==
                                                  false
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.isSelectedTripType.value ==
                                          false) {
                                        controller.isSelectedTripType.value =
                                            true;
                                      }
                                      controller.update();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.only(top: 5.h, left: 15.w),
                                      width: 80.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: controller
                                                    .isSelectedTripType.value ==
                                                true
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      child: Text(
                                        '${bookingDetail?.slices?[1].origin?.iataCode ?? ''} - ${bookingDetail?.slices?[1].destination?.iataCode ?? ''}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: controller.isSelectedTripType
                                                      .value ==
                                                  true
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SliverToBoxAdapter(),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: MySliverPersistentHeaderDelegate(
                          text: 'Choose a seat',
                          subtext: 'Choose your most comfortable seat',
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 0.h),
                      child: Column(
                        children: [
                          controller.isSelectedTripType.value == false
                              ? SizedBox(
                                  height: 55.h * (allRowList!.length - 11),
                                  width: Get.width,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: allRowList!.length - 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index1) {
                                      return ChooseASeat(
                                        seatSelectionCount:
                                            controller.seatSelectionCount.value,
                                        onTapSeat: (v) {
                                          // log('Count value=== ${v.availableServices![controller.seatSelectionCount.value].id.toString()}');

                                          log('v.isSelected=== ${v.isSelected}');
                                          if (v.isSelected == true) {
                                            controller.seatSelection.add(
                                              SeatSelection(
                                                type: 'oneWay',
                                                quantity: 1,
                                                id: v
                                                    .availableServices?[
                                                        controller
                                                            .seatSelectionCount
                                                            .value]
                                                    .id,
                                                price: v
                                                    .availableServices?[
                                                        controller
                                                            .seatSelectionCount
                                                            .value]
                                                    .totalAmount,
                                              ),
                                            );
                                            controller
                                                .seatSelectionCount.value++;
                                            log('First  Count Increment value=== ${controller.seatSelectionCount.value}');
                                          } else {
                                            controller
                                                .seatSelectionCount.value--;
                                            log('Entered valuew${controller.seatSelectionCount.value}');
                                            log('Entered');
                                            controller.seatSelection.removeAt(
                                              controller
                                                  .seatSelectionCount.value,
                                            );
                                            log('Length 444 ${controller.seatSelection.length.toString()}');
                                            log('First  Count Decrement value=== ${controller.seatSelectionCount.value}');
                                          }
                                          log(v.id.toString());
                                        },
                                        allRowList: allRowList!,
                                        controller: controller,
                                        index1: index1,
                                        passangersList:
                                            bookingDetail?.passengers,
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      55.h * (allReturnRowList!.length - 11),
                                  width: Get.width,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: allReturnRowList!.length - 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index1) {
                                      return ChooseASeat(
                                        seatSelectionCount: controller
                                            .returnSeatSelectionCount.value,
                                        onTapSeat: (v) {
                                          log('Second Count value=== ${controller.returnSeatSelectionCount.value}');
                                          log('v.isSelected=== ${v.isSelected}');
                                          if (v.isSelected == true) {
                                            controller.seatSelection.add(
                                              SeatSelection(
                                                type: 'return',
                                                quantity: 1,
                                                id: v
                                                    .availableServices?[controller
                                                        .returnSeatSelectionCount
                                                        .value]
                                                    .id,
                                                price: v
                                                    .availableServices?[controller
                                                        .returnSeatSelectionCount
                                                        .value]
                                                    .totalAmount,
                                              ),
                                            );
                                            controller.returnSeatSelectionCount
                                                .value++;
                                          } else {
                                            controller.returnSeatSelectionCount
                                                .value--;
                                            log('Entered');
                                            controller.seatSelection.removeAt(
                                                controller
                                                    .returnSeatSelectionCount
                                                    .value);
                                            log('Length 444 ${controller.seatSelection.length.toString()}');
                                          }
                                          log(v.id.toString());
                                        },
                                        allRowList: allReturnRowList!,
                                        controller: controller,
                                        index1: index1,
                                        passangersList:
                                            bookingDetail?.passengers,
                                      );
                                    },
                                  ),
                                ),

                          SizedBox(
                            height: 25.h,
                          ),

                          // SizedBox(
                          //   height: 120.h,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, -1),
                        ),
                      ],
                    ),
                    height: 60.h,
                    width: Get.width,
                    child: InkWell(
                      onTap: controller.onTapDone,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 8.h,
                          bottom: 8.h,
                          left: 15.w,
                          right: 15.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontFamily: FontHelper.boldFont,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 70.h,
                  left: 15.r,
                  right: 15.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(0, -1),
                        ),
                      ],
                    ),
                    height: 40.h,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Selected',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontFamily: FontHelper.boldFont,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Unavailable',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontFamily: FontHelper.boldFont,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Include',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontFamily: FontHelper.boldFont,
                              ),
                            ),
                          ],
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
}

class OneWayTripWidget extends StatelessWidget {
  final Function()? onTap;
  final VoidCallback? onTapFlightDetails;
  final String? airLineName;
  final String? aitLineLogo;
  final String? departDate;
  final String? departItaCode;
  final String? arriveItaCode;
  final String? duration;
  final String? departTime;
  final String? arriveTime;
  final String? offerExpiary;
  final String? price;
  const OneWayTripWidget({
    super.key,
    this.onTap,
    this.arriveTime,
    this.duration,
    this.airLineName,
    this.departDate,
    this.price,
    this.aitLineLogo,
    this.arriveItaCode,
    this.departItaCode,
    this.departTime,
    this.offerExpiary,
    this.onTapFlightDetails,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h, left: 5.w, right: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        height: 158.h,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.onWayTripBgImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        child: SvgPicture.network(
                          aitLineLogo ?? '',
                          placeholderBuilder: (BuildContext context) =>
                              const SizedBox(),
                          width: 14.h, // Specify desired width
                          height: 14.w, // Specify desired height
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Text(
                          airLineName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: FontHelper
                                .semiBoldFont, // Replace with your FontHelper
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  dateFormatString(departDate ?? ''),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.semiBoldFont, // Replace with your FontHelper
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            FlightData(
              destinationLocationName: arriveItaCode ?? '',
              destinationTime: arriveTime ?? '',
              flightType: 'Non Stop',
              dottedLineImg: ImageConstant.forwardDottedLineIcon,
              landLogoIcon: ImageConstant.flightLandIcon,
              originLocationName: departItaCode ?? '',
              originTime: departTime ?? '',
              takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
              totalTime: duration ?? '',
            ),
            SizedBox(
              height: 6.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onTapFlightDetails,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 3.w),
                  child: Text(
                    'Flight Details',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue,
                      fontFamily:
                          FontHelper.boldFont, // Replace with your FontHelper
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const Spacer(),
            Container(
              height: 0.5.h,
              width: Get.width * 0.83,
              color: Colors.grey,
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                Text(
                  '\$$price',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
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
    );
  }
}

class RoundTripWidget extends StatelessWidget {
  final Function()? onTap;
  const RoundTripWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: 190.h,
        width: 395.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.roundTripBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        child: Image.asset(
                          ImageConstant.airlineLogoIcon,
                          fit: BoxFit.contain,
                          height: 16.h,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Text(
                          'Lion Air ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                            fontFamily: FontHelper
                                .semiBoldFont, // Replace with your FontHelper
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '24 March 2024',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.semiBoldFont, // Replace with your FontHelper
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            const FlightData(
              destinationLocationName: 'JFK',
              destinationTime: '05:00',
              flightType: 'Non Stop',
              dottedLineImg: ImageConstant.forwardDottedLineIcon,
              landLogoIcon: ImageConstant.flightLandIcon,
              originLocationName: 'JFK',
              originTime: '05:00',
              takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
              totalTime: '1h 30 min',
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  // flightDetailsBottomSheet();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 3.w),
                  child: Text(
                    'Flight Details',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.blue,
                      fontFamily:
                          FontHelper.boldFont, // Replace with your FontHelper
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const Divider(),
            const Spacer(),
            const FlightData(
              destinationLocationName: 'JFK',
              dottedLineImg: ImageConstant.backwardDottedLineIcon,
              destinationTime: '05:00',
              flightType: 'Non Stop',
              landLogoIcon: ImageConstant.returnAirlineTakeOffIcon,
              originLocationName: 'JFK',
              originTime: '05:00',
              takeOffLogoIcon: ImageConstant.returnAirlineLandIcon,
              totalTime: '1h 30 min',
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Image.asset(
                  ImageConstant.offerTimeIcon,
                  height: 16.h,
                  width: 15.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'Offer Expires in :',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '2 days',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    fontFamily:
                        FontHelper.semiBoldFont, // Replace with your FontHelper
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${678}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 3.w),
                    child: Text(
                      'Flight Details',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.blue,
                        fontFamily:
                            FontHelper.boldFont, // Replace with your FontHelper
                      ),
                    ),
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
    );
  }
}

class FlightData extends StatelessWidget {
  final String? originLocationName;
  final String? destinationLocationName;
  final String? originTime;
  final String? destinationTime;
  final String? flightType;
  final String? totalTime;
  final String? takeOffLogoIcon;
  final String? landLogoIcon;
  final String? dottedLineImg;

  const FlightData({
    super.key,
    this.originLocationName,
    this.destinationLocationName,
    this.destinationTime,
    this.flightType,
    this.landLogoIcon,
    this.originTime,
    this.takeOffLogoIcon,
    this.dottedLineImg,
    this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  originLocationName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset(
                  takeOffLogoIcon ?? '',
                  color: Colors.black,
                  height: 16.h,
                  width: 16.w,
                ),
              ],
            ),
            Text(
              originTime ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontFamily:
                    FontHelper.semiBoldFont, // Replace with your FontHelper
              ),
            ),
          ],
        ),
        // SizedBox(
        //   width: 10.w,
        // ),

        const Spacer(),
        Column(
          children: [
            Text(
              flightType ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.blue,
                fontFamily:
                    FontHelper.semiBoldFont, // Replace with your FontHelper
              ),
            ),
            Image.asset(
              dottedLineImg ?? '',
              fit: BoxFit.contain,
              width: Get.width * 0.3,
            ),
            Text(
              totalTime ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontFamily:
                    FontHelper.semiBoldFont, // Replace with your FontHelper
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset(
                  landLogoIcon ?? '',
                  color: Colors.black,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  destinationLocationName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
                  ),
                ),
              ],
            ),
            Text(
              destinationTime ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontFamily:
                    FontHelper.semiBoldFont, // Replace with your FontHelper
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  String? text;
  String? subtext;

  MySliverPersistentHeaderDelegate({
    this.text,
    this.subtext,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontFamily: FontHelper.boldFont, // Replace with your FontHelper
            ),
          ),
          Text(
            subtext ?? '',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
              fontFamily:
                  FontHelper.semiBoldFont, // Replace with your FontHelper
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 64.0; // Maximum height of the header

  @override
  double get minExtent => 64.0; // Minimum height of the header

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Return true if the header should be rebuilt
  }
}

class SeatSelectionCountView extends StatelessWidget {
  final List<int>? seatCount;
  const SeatSelectionCountView({super.key, this.seatCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.06,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        childAspectRatio: 3.3 / 5.6,
        shrinkWrap: true,
        children: List.generate(
          seatCount?.length ?? 0,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0.r),
                  ),
                ),
                child: Text(
                  seatCount?[index].toString() ?? '',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontFamily:
                        FontHelper.boldFont, // Replace with your FontHelper
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChooseASeat extends StatelessWidget {
  SeatBookingController controller;
  RxList<Rows> allRowList;
  int index1;
  List? passangersList;
  int seatSelectionCount;
  final Function(Elements)? onTapSeatSelection;
  final Function(Elements)? onTapSeat;
  ChooseASeat({
    super.key,
    required this.controller,
    required this.index1,
    this.passangersList,
    required this.allRowList,
    required this.seatSelectionCount,
    this.onTapSeatSelection,
    this.onTapSeat,
  });

  @override
  Widget build(BuildContext context) {
    return allRowList[index1 + 1].sections!.any(
              (element) => element.elements!.any(
                (element) => element.type == 'exit_row',
              ),
            )
        ? Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Icon(Icons.arrow_forward_sharp),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(
              allRowList[index1 + 1].sections?.length ?? 0,
              (index2) => Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.26,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: index2 == 2
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: List<Widget>.generate(
                        allRowList[index1 + 1]
                                .sections?[index2]
                                .elements
                                ?.length ??
                            0,
                        (index3) => Column(
                          children: [
                            allRowList[index1 + 1]
                                    .sections![index2]
                                    .elements!
                                    .any(
                                      (element) => element.designator == null,
                                    )
                                ? Container(
                                    padding: EdgeInsets.all(
                                      7.r,
                                    ),
                                    margin: EdgeInsets.all(
                                      2.r,
                                    ),
                                    height: 26.h,
                                    width: Get.width * 0.24,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(
                                        2.r,
                                      ),
                                    ),
                                    child: allRowList[index1 + 1]
                                                .sections![index2]
                                                .elements![index3]
                                                .type ==
                                            'lavatory'
                                        ? Image.asset(
                                            ImageConstant.lavoratoryIcon,
                                            height: 15.h,
                                            width: 15.w,
                                            fit: BoxFit.contain,
                                          )
                                        : allRowList![index1 + 1]
                                                    .sections![index2]
                                                    .elements![index3]
                                                    .type ==
                                                'galley'
                                            ? Image.asset(
                                                ImageConstant.galleryIcon,
                                                height: 15.h,
                                                width: 15.w,
                                                fit: BoxFit.contain,
                                              )
                                            : const SizedBox(),
                                  )
                                : allRowList[index1 + 1]
                                        .sections![index2]
                                        .elements![index3]
                                        .availableServices!
                                        .isEmpty
                                    ? Container(
                                        margin: EdgeInsets.all(
                                          2.r,
                                        ),
                                        height: 26.h,
                                        width: 26.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              2.0.r,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          allRowList[index1 + 1]
                                                  .sections?[index2]
                                                  .elements?[index3]
                                                  .designator
                                                  .toString()
                                                  .characters
                                                  .last ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.white,
                                            fontFamily: FontHelper
                                                .boldFont, // Replace with your FontHelper
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          // onTapSeatSelection != null
                                          //     ? onTapSeatSelection!(
                                          //         allRowList[index1 + 1]
                                          //                 .sections?[index2]
                                          //                 .elements?[index3] ??
                                          //             Elements())
                                          //     : null;

                                          log('seatSelectionCount ${seatSelectionCount.toString()}');
                                          if (allRowList[index1 + 1]
                                                  .sections?[index2]
                                                  .elements?[index3]
                                                  .isSelected ==
                                              true) {
                                            log('condition true');
                                            allRowList[index1 + 1]
                                                .sections?[index2]
                                                .elements?[index3]
                                                .isSelected = false;

                                            seatSelectionCount - 1;
                                            onTapSeat != null
                                                ? onTapSeat!(
                                                    allRowList[index1 + 1]
                                                            .sections?[index2]
                                                            .elements?[index3] ??
                                                        Elements(),
                                                  )
                                                : null;
                                          } else if (seatSelectionCount ==
                                              passangersList?.length) {
                                            CustomToast.showToast(
                                              'Seats are selected for all passangers',
                                            );
                                          } else {
                                            log('condition false');
                                            allRowList[index1 + 1]
                                                .sections?[index2]
                                                .elements?[index3]
                                                .isSelected = true;

                                            seatSelectionCount + 1;
                                            onTapSeat != null
                                                ? onTapSeat!(
                                                    allRowList[index1 + 1]
                                                            .sections?[index2]
                                                            .elements?[index3] ??
                                                        Elements(),
                                                  )
                                                : null;
                                          }
                                          controller.update();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(
                                            2.r,
                                          ),
                                          height: 26.h,
                                          width: 26.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: allRowList[index1 + 1]
                                                        .sections?[index2]
                                                        .elements?[index3]
                                                        .isSelected ==
                                                    true
                                                ? Colors.blue
                                                : Colors.green,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                2.0.r,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            allRowList[index1 + 1]
                                                    .sections?[index2]
                                                    .elements?[index3]
                                                    .designator
                                                    .toString()
                                                    .characters
                                                    .last ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.white,
                                              fontFamily: FontHelper
                                                  .boldFont, // Replace with your FontHelper
                                            ),
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  index2 == 2
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(
                            2.0,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  2.0.r,
                                ),
                              ),
                            ),
                            child: Text(
                              allRowList[index1 + 1]
                                          .sections![index2]
                                          .elements!
                                          .any(
                                            (element) =>
                                                element.designator == null,
                                          ) ||
                                      allRowList[index1 + 1]
                                          .sections![index2]
                                          .elements!
                                          .isEmpty
                                  ? ''
                                  : index1 > 9
                                      ? '${28 + index1 - 1}'
                                      : '${28 + index1}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black,
                                fontFamily: FontHelper
                                    .boldFont, // Replace with your FontHelper
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}
