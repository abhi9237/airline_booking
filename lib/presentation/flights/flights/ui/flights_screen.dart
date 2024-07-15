import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../../../core/constants/image_constant.dart';
import '../../../../core/font_helper/font_helper.dart';
import '../../modal/flight_detail_modal.dart';
import '../../passenger_contact_detail/ui/passanger_details_screen.dart';
import '../controller/flight_screen_controller.dart';

class FlightsScreen extends StatelessWidget {
  final FlightDataModal allFlightData;
  final bool isOneWayTrip;
  // final RxList<searchModal.Slices>? slicesDataList;
  // final RxList<searchModal.PassengerModal>? passengerModalList;
  final String? cabinClass;
  const FlightsScreen({
    super.key,
    required this.isOneWayTrip,
    // this.slicesDataList,
    // this.passengerModalList,
    this.cabinClass,
    required this.allFlightData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FlightScreenController>(
        init: FlightScreenController(
            cabinClass: cabinClass,
            // passengerModalList: passengerModalList,
            // slicesDataList: slicesDataList,
            allFlightData: allFlightData),
        builder: (controller) {
          return controller.isLoading.value == true
              ? shimmerEffect()
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.45,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      Positioned(
                        top: 28.h,
                        left: 12.w,
                        right: 12.w,
                        bottom: 0,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .flightOriginToDestinationLocation(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontFamily: FontHelper
                                              .boldFont, // Replace with your FontHelper
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .formattedNullableDateString(
                                              controller.allFlightData.data,
                                            ),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                              fontFamily: FontHelper
                                                  .semiBoldFont, // Replace with your FontHelper
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 3.w,
                                              right: 3.w,
                                            ),
                                            height: 12.h,
                                            width: 0.5.w,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            controller.adultChildCount(),
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                              fontFamily: FontHelper
                                                  .semiBoldFont, // Replace with your FontHelper
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
                              height: 10.h,
                            ),
                            Visibility(
                              visible: controller.allFlightData.data != null &&
                                  controller.allFlightData.data?.offers !=
                                      null &&
                                  controller
                                      .allFlightData.data!.offers!.isNotEmpty,
                              child: Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(top: 10.h),
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .allFlightData.data?.offers?.length,
                                  itemBuilder: (context, index) {
                                    return isOneWayTrip == true
                                        ? OneWayTripWidget(
                                            controller: controller,
                                            index: index,
                                            onTap: () {
                                              Get.to(
                                                () =>
                                                    PassangerContactDetailsScreen(
                                                  classType: controller
                                                      ?.allFlightData
                                                      .data
                                                      ?.cabinClass,
                                                  isOneWayTrip: isOneWayTrip,
                                                  passengers: controller
                                                          .allFlightData
                                                          .data
                                                          ?.passengers ??
                                                      [],
                                                  offerId: controller
                                                          .allFlightData
                                                          .data
                                                          ?.offers?[index]
                                                          .id ??
                                                      '',
                                                  offer: (controller
                                                                  .allFlightData
                                                                  .data
                                                                  ?.offers !=
                                                              null &&
                                                          controller
                                                              .allFlightData
                                                              .data!
                                                              .offers!
                                                              .isNotEmpty)
                                                      ? controller.allFlightData
                                                          .data?.offers![index]
                                                      : Offers(),
                                                ),
                                              );
                                            },
                                          )
                                        : RoundTripWidget(
                                            controller: controller,
                                            index: index,
                                            onTap: () {
                                              Get.to(
                                                () =>
                                                    PassangerContactDetailsScreen(
                                                  classType: controller
                                                      ?.allFlightData
                                                      .data
                                                      ?.cabinClass,
                                                  passengers: controller
                                                          .allFlightData
                                                          .data
                                                          ?.passengers ??
                                                      [],
                                                  offer: (controller
                                                                  .allFlightData
                                                                  .data
                                                                  ?.offers !=
                                                              null &&
                                                          controller
                                                              .allFlightData
                                                              .data!
                                                              .offers!
                                                              .isNotEmpty)
                                                      ? controller.allFlightData
                                                          .data?.offers![index]
                                                      : Offers(),
                                                  offerId: controller
                                                          .allFlightData
                                                          .data
                                                          ?.offers?[index]
                                                          .id ??
                                                      '',
                                                  isOneWayTrip: isOneWayTrip,
                                                ),
                                              );
                                            },
                                          );
                                  },
                                ),
                              ),
                            ),
                          ],
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
  final FlightScreenController? controller;
  final int? index;
  final Function()? onTap;
  const OneWayTripWidget({super.key, this.onTap, this.controller, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (controller?.formattedTimes[index ?? 0].value == '00:00') {
          CustomToast.showToast(
            'Your current offer expires please create new offer',
          );
        } else {
          onTap != null ? onTap!() : null;
        }

        // if (controller?.offerExpires(
        //         controller?.allFlightData.data?.offers?[index!].updatedAt ?? '',
        //         controller?.allFlightData.data?.offers?[index!].expiresAt ??
        //             '') ==
        //     '00:00') {
        //   CustomToast.showToast(
        //     'Your current offer expires please create new offer',
        //   );
        // } else {
        //   onTap != null ? onTap!() : null;
        // }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: 160.h,
        width: 100.w,
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
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        child: SvgPicture.network(
                          controller?.allFlightData.data?.offers?[index ?? 0]
                                  .owner?.logoSymbolUrl ??
                              '',
                          placeholderBuilder: (BuildContext context) =>
                              const SizedBox(),
                          width: 14.h, // Specify desired width
                          height: 14.w, //
                          fit: BoxFit.cover, // Specify desired height
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Text(
                          controller?.allFlightData.data?.offers?[index ?? 0]
                                  .owner?.name ??
                              '',
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
                  dateFormatString(
                    controller?.allFlightData.data?.offers?[index ?? 0]
                            .slices?[0].segments?[0].departingAt ??
                        '',
                  ),
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
              height: 10.h,
            ),
            FlightData(
              destinationLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[0].destination?.iataCode ??
                  '',
              destinationTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
                        .segments?[0].arrivingAt ??
                    '',
              ),
              flightType: controller!.getAirlineStops().isEmpty
                  ? 'Non Stop'
                  : controller?.getAirlineStops(),
              dottedLineImg: ImageConstant.forwardDottedLineIcon,
              landLogoIcon: ImageConstant.flightLandIcon,
              originLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[0].origin?.iataCode ??
                  '',
              originTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
                        .segments?[0].departingAt ??
                    '',
              ),
              takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
              totalTime: controller?.allFlightData.data?.offers?[index ?? 0]
                  .slices?[0].segments?[0].duration
                  ?.replaceFirst('PT', '')
                  .replaceFirst('P1DT', '')
                  .replaceFirst('P2DT', ''),
            ),
            SizedBox(
              height: 3.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  flightDetailsBottomSheet(
                    classType: controller?.allFlightData.data?.cabinClass ==
                            'economy'
                        ? 'Economy'
                        : controller?.allFlightData.data?.cabinClass == 'first'
                            ? 'First Class'
                            : controller?.allFlightData.data?.cabinClass ==
                                    'premium_economy'
                                ? 'Premium Economy'
                                : 'Business',
                    airLineName: controller?.allFlightData.data
                            ?.offers?[index ?? 0].owner?.name ??
                        '',
                    arriveDate:
                        controller!.formattedNullAbleStringArriveDateIndex(
                      controller?.allFlightData.data,
                      index ?? 0,
                      0,
                    ),
                    arriveTime: convertTime(
                      controller?.allFlightData.data?.offers?[index ?? 0]
                              .slices?[0].segments?[0].arrivingAt ??
                          '',
                    ),
                    carryBagCount: controller?.carryOnBagCount(
                      controller?.allFlightData.data ?? Data(),
                      index ?? 0,
                    ),
                    checkedBagCount: controller?.checkedBagCount(
                      controller?.allFlightData.data ?? Data(),
                      index ?? 0,
                    ),
                    departureDate:
                        controller!.formattedNullAbleStringDepartDateIndex(
                      controller?.allFlightData.data,
                      index ?? 0,
                      0,
                    ),
                    departureTime: convertTime(
                      controller?.allFlightData.data?.offers?[index ?? 0]
                              .slices?[0].segments?[0].departingAt ??
                          '',
                    ),
                    destinationItaCode: controller
                            ?.allFlightData
                            .data
                            ?.offers?[index ?? 0]
                            .slices?[0]
                            .destination
                            ?.iataCode ??
                        '',
                    destinationLocation:
                        '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].destination?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].destination?.iataCityCode ?? ''})',
                    duration: controller?.allFlightData.data
                            ?.offers?[index ?? 0].slices?[0].duration
                            ?.replaceFirst('PT', '')
                            .replaceFirst('P1DT', '')
                            .replaceFirst('P2DT', '') ??
                        '',
                    originItaCode: controller?.allFlightData.data
                            ?.offers?[index ?? 0].slices?[0].origin?.iataCode ??
                        '',
                    originLocation:
                        '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].origin?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].origin?.iataCityCode ?? ''})',
                  );
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
              height: 5.h,
            ),
            const Spacer(),
            const Divider(),
            const Spacer(),
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
                ValueListenableBuilder<String>(
                  valueListenable: controller!.formattedTimes[index ?? 0],
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontFamily: FontHelper
                            .semiBoldFont, // Replace with your FontHelper
                      ),
                    );
                  },
                ),
                const Spacer(),
                Text(
                  '\$${controller?.allFlightData.data?.offers?[index ?? 0].baseAmount}',
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
  final FlightScreenController? controller;
  final int? index;
  final Function()? onTap;
  const RoundTripWidget({super.key, this.onTap, this.controller, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller?.formattedTimes[index ?? 0].value == '00:00') {
          CustomToast.showToast(
            'Your current offer expires please create new offer',
          );
        } else {
          onTap != null ? onTap!() : null;
        }

        // if (controller?.offerExpires(
        //       controller?.allFlightData.data?.offers?[index!].updatedAt ?? '',
        //       controller?.allFlightData.data?.offers?[index!].expiresAt ?? '',
        //     ) ==
        //     '00:00') {
        //   CustomToast.showToast(
        //     'Your current offer expires please create new offer',
        //   );
        // } else {
        //   onTap != null ? onTap!() : null;
        // }
      },
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
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        child: SvgPicture.network(
                          controller?.allFlightData.data?.offers?[index ?? 0]
                                  .owner?.logoSymbolUrl ??
                              '',
                          placeholderBuilder: (BuildContext context) =>
                              const SizedBox(),
                          width: 12.h, // Specify desired width
                          height: 12.w, // Specify desired height
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Text(
                          controller?.allFlightData.data?.offers?[index ?? 0]
                                  .owner?.name ??
                              '',
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
                  controller!.formattedNullAbleStringDepartDateIndex(
                    controller?.allFlightData.data,
                    index ?? 0,
                    0,
                  ),
                  // dateFormatString(
                  //   controller?.allFlightData.data?.offers?[index ?? 0]
                  //           .slices?[0].segments?[0].departingAt ??
                  //       '',
                  // ),
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
            FlightData(
              destinationLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[0].destination?.iataCode ??
                  '',
              destinationTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
                        .segments?[0].arrivingAt ??
                    '',
              ),
              flightType: 'Non Stop',
              dottedLineImg: ImageConstant.forwardDottedLineIcon,
              landLogoIcon: ImageConstant.flightLandIcon,
              originLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[0].origin?.iataCode ??
                  '',
              originTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
                        .segments?[0].departingAt ??
                    '',
              ),
              takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
              totalTime: controller?.allFlightData.data?.offers?[index ?? 0]
                      .slices?[0].segments?[0].duration
                      ?.replaceFirst('PT', '')
                      .replaceFirst('P1DT', '')
                      .replaceFirst('P2DT', '') ??
                  '',
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  flightDetailsBottomSheet(
                    classType: controller?.allFlightData.data?.cabinClass ==
                            'economy'
                        ? 'Economy'
                        : controller?.allFlightData.data?.cabinClass == 'first'
                            ? 'First Class'
                            : controller?.allFlightData.data?.cabinClass ==
                                    'premium_economy'
                                ? 'Premium Economy'
                                : 'Business',
                    airLineName: controller?.allFlightData.data
                            ?.offers?[index ?? 0].owner?.name ??
                        '',
                    arriveDate:
                        controller!.formattedNullAbleStringArriveDateIndex(
                      controller?.allFlightData.data,
                      index ?? 0,
                      0,
                    ),
                    arriveTime: convertTime(
                      controller?.allFlightData.data?.offers?[index ?? 0]
                              .slices?[0].segments?[0].arrivingAt ??
                          '',
                    ),
                    carryBagCount: controller?.carryOnBagCount(
                      controller?.allFlightData.data ?? Data(),
                      index ?? 0,
                    ),
                    checkedBagCount: controller?.checkedBagCount(
                      controller?.allFlightData.data ?? Data(),
                      index ?? 0,
                    ),
                    departureDate:
                        controller!.formattedNullAbleStringDepartDateIndex(
                      controller?.allFlightData.data,
                      index ?? 0,
                      0,
                    ),
                    departureTime: convertTime(
                      controller?.allFlightData.data?.offers?[index ?? 0]
                              .slices?[0].segments?[0].departingAt ??
                          '',
                    ),
                    destinationItaCode: controller
                            ?.allFlightData
                            .data
                            ?.offers?[index ?? 0]
                            .slices?[0]
                            .destination
                            ?.iataCode ??
                        '',
                    destinationLocation:
                        '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].destination?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].destination?.iataCityCode ?? ''})',
                    duration: controller
                            ?.allFlightData
                            .data
                            ?.offers?[index ?? 0]
                            .slices?[0]
                            .segments?[0]
                            .duration
                            ?.replaceFirst('PT', '')
                            .replaceFirst('P1DT', '')
                            .replaceFirst('P2DT', '') ??
                        '',
                    originItaCode: controller?.allFlightData.data
                            ?.offers?[index ?? 0].slices?[0].origin?.iataCode ??
                        '',
                    originLocation:
                        '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].origin?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[0].origin?.iataCityCode ?? ''})',
                  );
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
            FlightData(
              destinationLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[1].destination?.iataCode ??
                  '',
              destinationTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[1]
                        .segments?[0].arrivingAt ??
                    '',
              ),
              flightType: 'Non Stop',
              dottedLineImg: ImageConstant.forwardDottedLineIcon,
              landLogoIcon: ImageConstant.flightLandIcon,
              originLocationName: controller?.allFlightData.data
                      ?.offers?[index ?? 0].slices?[1].origin?.iataCode ??
                  '',
              originTime: convertTime(
                controller?.allFlightData.data?.offers?[index ?? 0].slices?[1]
                        .segments?[0].departingAt ??
                    '',
              ),
              takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
              totalTime: controller?.allFlightData.data?.offers?[index ?? 0]
                  .slices?[1].segments?[0].duration
                  ?.replaceFirst('PT', '')
                  .replaceFirst('P1DT', '')
                  .replaceFirst('P2DT', ''),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImageConstant.offerTimeIcon,
                  height: 16.h,
                  width: 15.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 3.w,
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
                ValueListenableBuilder<String>(
                  valueListenable: controller!.formattedTimes[index ?? 0],
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontFamily: FontHelper
                            .semiBoldFont, // Replace with your FontHelper
                      ),
                    );
                  },
                ),
                // Obx(
                //   () => Text(
                //     controller?.formattedTime.value ?? '',
                //     // controller?.offerExpires(
                //     //         controller?.allFlightData.data?.offers ?? []) ??
                //     //     '',
                //     // controller?.offerExpires(
                //     //         controller?.allFlightData.data?.offers?[index ?? 0]
                //     //                 .updatedAt ??
                //     //             '',
                //     //         controller?.allFlightData.data?.offers?[index ?? 0]
                //     //                 .expiresAt ??
                //     //             '') ??
                //     //     '',
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //       fontSize: 12.sp,
                //       color: Colors.grey,
                //       fontFamily: FontHelper
                //           .semiBoldFont, // Replace with your FontHelper
                //     ),
                //   ),
                // ),

                SizedBox(
                  width: 5.w,
                ),
                // const Spacer(),
                Expanded(
                  child: Text(
                    '\$${controller?.allFlightData.data?.offers?[index ?? 0].baseAmount}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.blue,
                      fontFamily:
                          FontHelper.boldFont, // Replace with your FontHelper
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 5.w,
                // ),
                // const Spacer(),
                InkWell(
                  onTap: () {
                    flightDetailsBottomSheet(
                      classType: controller?.allFlightData.data?.cabinClass ==
                              'economy'
                          ? 'Economy'
                          : controller?.allFlightData.data?.cabinClass ==
                                  'first'
                              ? 'First Class'
                              : controller?.allFlightData.data?.cabinClass ==
                                      'premium_economy'
                                  ? 'Premium Economy'
                                  : 'Business',
                      airLineName: controller?.allFlightData.data
                              ?.offers?[index ?? 0].owner?.name ??
                          '',
                      arriveDate:
                          controller!.formattedNullAbleStringArriveDateIndex(
                        controller?.allFlightData.data,
                        index ?? 0,
                        1,
                      ),
                      arriveTime: convertTime(
                        controller?.allFlightData.data?.offers?[index ?? 0]
                                .slices?[1].segments?[0].arrivingAt ??
                            '',
                      ),
                      carryBagCount: controller?.carryOnBagCount(
                        controller?.allFlightData.data ?? Data(),
                        index ?? 0,
                      ),
                      checkedBagCount: controller?.checkedBagCount(
                        controller?.allFlightData.data ?? Data(),
                        index ?? 0,
                      ),
                      departureDate:
                          controller!.formattedNullAbleStringDepartDateIndex(
                        controller?.allFlightData.data,
                        index ?? 0,
                        1,
                      ),
                      departureTime: convertTime(
                        controller?.allFlightData.data?.offers?[index ?? 0]
                                .slices?[1].segments?[0].departingAt ??
                            '',
                      ),
                      destinationItaCode: controller
                              ?.allFlightData
                              .data
                              ?.offers?[index ?? 0]
                              .slices?[1]
                              .destination
                              ?.iataCode ??
                          '',
                      destinationLocation:
                          '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[1].destination?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[1].destination?.iataCityCode ?? ''})',
                      duration: controller
                              ?.allFlightData
                              .data
                              ?.offers?[index ?? 0]
                              .slices?[1]
                              .segments?[0]
                              .duration
                              ?.replaceFirst('PT', '')
                              .replaceFirst('P1DT', '')
                              .replaceFirst('P2DT', '') ??
                          '',
                      originItaCode: controller
                              ?.allFlightData
                              .data
                              ?.offers?[index ?? 0]
                              .slices?[1]
                              .origin
                              ?.iataCode ??
                          '',
                      originLocation:
                          '${controller?.allFlightData.data?.offers?[index ?? 0].slices?[1].origin?.cityName ?? ''} (${controller?.allFlightData.data?.offers?[index ?? 0].slices?[1].origin?.iataCityCode ?? ''})',
                    );
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
            SizedBox(
              height: 3.h,
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
            SizedBox(
              height: 3.h,
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

Widget shimmerEffect() {
  return Stack(
    children: [
      // Shimmer effect layer
      Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[200]!,
        child: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              // Top Image shimmer placeholder
              Container(
                height: Get.height * 0.35,
                width: Get.width,
                color: Colors.grey[800], // Placeholder for image
              ),
              // Content shimmer placeholders
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: Get.height * 0.3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 35),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(7.r),
                          margin: EdgeInsets.only(bottom: 8.h),
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Image placeholder shimmer effect
                              Container(
                                height: 85.h,
                                width: 90.w,
                                color:
                                    Colors.grey[300], // Placeholder for image
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 12.h,
                                      color: Colors
                                          .grey[300], // Placeholder for text
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      width: 80.w,
                                      height: 10.h,
                                      color: Colors
                                          .grey[300], // Placeholder for text
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      width: 50.w,
                                      height: 20.h,
                                      color: Colors.grey[
                                          300], // Placeholder for rating container
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              // Placeholder for 'Details' button
                              Container(
                                alignment: Alignment.center,
                                height: 35.h,
                                width: 75.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
