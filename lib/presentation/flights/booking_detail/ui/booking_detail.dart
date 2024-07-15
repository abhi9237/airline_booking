import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/constants/image_constant.dart';
import '../../../../core/font_helper/font_helper.dart';
import '../../modal/flight_detail_modal.dart';
import '../../passenger_contact_detail/modal/passanger_contact_detail_modal.dart';
import '../../seat_book/ui/seat_booking.dart';
import '../controller/booking_detail_controller.dart';

class BookingDetailScreen extends StatelessWidget {
  final Offers? bookingDetail;
  final bool? isOneWayTrip;
  final List<Payments>? payments;
  final List<PassengerModal>? passangerList;
  final String? classType;
  const BookingDetailScreen({
    super.key,
    this.bookingDetail,
    this.isOneWayTrip,
    this.payments,
    this.passangerList,
    this.classType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<BookingDetailsController>(
        init: BookingDetailsController(
          isOneWayTripSelected: isOneWayTrip,
          offerId: bookingDetail?.id ?? '',
        ),
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
                          height: isOneWayTrip == false
                              ? Get.height * 0.57
                              : Get.height * 0.35,
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
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 2.w,
                                          right: 8.w,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 10.w,
                                    // ),
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
                                onTap: () {},
                                onTapFlightDetails: () {
                                  controller.onTapFlightDetails(
                                    index: 0,
                                    offer: bookingDetail,
                                    classType: classType,
                                  );
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
                              isOneWayTrip == false
                                  ? OneWayTripWidget(
                                      onTap: () {},
                                      onTapFlightDetails: () {
                                        controller.onTapFlightDetails(
                                          index: 1,
                                          offer: bookingDetail,
                                          classType: classType,
                                        );
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
                                        0,
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
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: MySliverPersistentHeaderDelegate(
                          text: 'Passengers Details',
                        ),
                      ),
                    ];
                  },
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              top: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(
                                  visible: (passangerList != null &&
                                      passangerList!.isNotEmpty),
                                  child: SizedBox(
                                    height: Get.height *
                                        0.38 *
                                        passangerList!.length,
                                    child: ListView.builder(
                                      itemCount: passangerList!.length,
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          height: Get.height * 0.38,
                                          width: Get.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 25.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.r,
                                                  ),
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                ),
                                                child: Text(
                                                  passangerList?[index].type ==
                                                          'adult'
                                                      ? 'Adult '
                                                      : passangerList?[index]
                                                                  .type ==
                                                              'child'
                                                          ? 'Child '
                                                          : 'Infant',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontFamily: FontHelper
                                                        .boldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h,
                                                ),
                                                height: Get.height * 0.31,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5.r,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Title',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .title ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Given Name',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .givenName ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Family Name',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .familyName ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Date of Birth',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .bornOn ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Passport Number',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .identityDocuments?[
                                                                      0]
                                                                  .passportNo ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Expiry Date',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                            fontFamily: FontHelper
                                                                .semiBoldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                        Text(
                                                          passangerList?[index]
                                                                  .identityDocuments?[
                                                                      0]
                                                                  .expireOn ??
                                                              '',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily: FontHelper
                                                                .boldFont, // Replace with your FontHelper
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Visibility(
                                  visible: controller.seatsDataList.isNotEmpty,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => SeatSelectionScreen(
                                          seatSelection:
                                              controller.seatSelection.value,
                                          bookingDetail: bookingDetail,
                                          isOneWaySelected: isOneWayTrip,
                                          allReturnRowList:
                                              controller.allReturnRowList,
                                          allRowList: controller.allRowList,
                                        ),
                                      )?.then((value) {
                                        if (value != null) {
                                          controller.seatSelection.value =
                                              value;
                                        }
                                        controller.update();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.r),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        border: Border.all(color: Colors.blue),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageConstant.seatSelectionIcon,
                                            height: 22.h,
                                            width: 22.w,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Seat Selection',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontFamily: FontHelper
                                                        .boldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                                Text(
                                                  controller.seatSelection.value
                                                          .isEmpty
                                                      ? 'Specify where on the plan you’d like to sit'
                                                      : 'Seats are selected for ${controller.seatSelection.value.length} passangers',
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: Colors.grey,
                                                    fontFamily: FontHelper
                                                        .boldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.blue,
                                            size: 18.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Payment Details ',
                                  // 'Paradise Resort',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontFamily: FontHelper.boldFont,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 10.h,
                                    bottom: 10.h,
                                  ),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Base Amount',
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.semiBoldFont,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '\$${bookingDetail?.baseAmount ?? ''}',
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
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 10.h,
                                    bottom: 10.h,
                                  ),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Tax Amount',
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.semiBoldFont,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '\$${bookingDetail?.taxAmount ?? ''}',
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
                                SizedBox(
                                  height: 10.h,
                                ),
                                Visibility(
                                  visible: controller.seatSelection.isNotEmpty,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 8.w,
                                      right: 8.w,
                                      top: 10.h,
                                      bottom: 10.h,
                                    ),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 10.h,
                                          width: 10.w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Seat Selection',
                                          // 'Paradise Resort',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                            fontFamily: FontHelper.semiBoldFont,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          controller.seatTotalAmount(
                                            seatSelection:
                                                controller.seatSelection.value,
                                          ),
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
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 10.h,
                                    bottom: 10.h,
                                  ),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 10.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Total Amount',
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper.semiBoldFont,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.totalAmount(
                                          seatSelection:
                                              controller.seatSelection,
                                          totalAmount:
                                              bookingDetail?.totalAmount ?? '',
                                        ),
                                        // 'Paradise Resort',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.blue,
                                          fontFamily: FontHelper.boldFont,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 70.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                    child: Obx(
                      () => controller.isLoadingBooking.value == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                controller.onTapBookNow(
                                  offers: bookingDetail,
                                  selectedPassengerList: passangerList,
                                  payments: payments,
                                  selectedOffers: [bookingDetail?.id ?? ''],
                                );
                              },
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
                                  'Book Now',
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class OneWayTripWidget extends StatelessWidget {
//   final Function()? onTap;
//   const OneWayTripWidget({super.key, this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 5.h),
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         height: 158.h,
//         width: Get.width,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(ImageConstant.onWayTripBgImg),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 8.h,
//             ),
//             Row(
//               children: [
//                 Flexible(
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.all(2.r),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey.withOpacity(0.7),
//                         ),
//                         child: Image.asset(
//                           ImageConstant.airlineLogoIcon,
//                           fit: BoxFit.contain,
//                           height: 16.h,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Lion Air ',
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 10.sp,
//                             color: Colors.black,
//                             fontFamily: FontHelper
//                                 .semiBoldFont, // Replace with your FontHelper
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Text(
//                   '24 March 2024',
//                   style: TextStyle(
//                     fontSize: 10.sp,
//                     color: Colors.black,
//                     fontFamily:
//                         FontHelper.semiBoldFont, // Replace with your FontHelper
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             const FlightData(
//               destinationLocationName: 'JFK',
//               destinationTime: '05:00',
//               flightType: 'Non Stop',
//               dottedLineImg: ImageConstant.forwardDottedLineIcon,
//               landLogoIcon: ImageConstant.flightLandIcon,
//               originLocationName: 'JFK',
//               originTime: '05:00',
//               takeOffLogoIcon: ImageConstant.flightTakeOffIcon,
//               totalTime: '1h 30 min',
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: InkWell(
//                 onTap: () {},
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 5.w, right: 3.w),
//                   child: Text(
//                     'Flight Details',
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       color: Colors.blue,
//                       fontFamily:
//                           FontHelper.boldFont, // Replace with your FontHelper
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 8.h,
//             ),
//             const Spacer(),
//             Container(
//               height: 0.5,
//               width: Get.width * 0.85,
//               color: Colors.grey,
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 const Spacer(),
//                 Text(
//                   '\$${678}',
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: Colors.blue,
//                     fontFamily:
//                         FontHelper.boldFont, // Replace with your FontHelper
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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

  MySliverPersistentHeaderDelegate({
    this.text,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 18.h),
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
          SizedBox(
            height: 1.h,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0; // Maximum height of the header

  @override
  double get minExtent => 50.0; // Minimum height of the header

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Return true if the header should be rebuilt
  }
}
