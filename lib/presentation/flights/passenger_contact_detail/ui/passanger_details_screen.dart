import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/common_text_form_filled/common_text_form_filled.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/constants/image_constant.dart';
import '../../../../core/country_code_picker/ui/country_code_picker.dart';
import '../../../../core/font_helper/font_helper.dart';
import '../../modal/flight_detail_modal.dart';
import '../controller/passenger_contact_details_controller.dart';
import '../modal/passanger_contact_detail_modal.dart';

class PassangerContactDetailsScreen extends StatelessWidget {
  String? offerId;
  bool? isOneWayTrip;
  Offers? offer;
  String? classType;
  List<Passengers>? passengers;
  PassangerContactDetailsScreen({
    super.key,
    this.offerId,
    this.offer,
    this.classType,
    this.isOneWayTrip,
    this.passengers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: PassangerContactDetailController(
          offerId: offerId ?? '',
          passengerList: passengers,
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
                                      'Details',
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
                                onTapFlightDetails: () {
                                  // log('Airport Name${offer?.slices?[0].segments?[0].stops?[0].airport?.name}');

                                  controller.onTapFlightDetails(
                                    offer: offer,
                                    classType: classType,
                                  );
                                },
                                duration: offer
                                        ?.slices?[0].segments?[0].duration
                                        ?.replaceFirst('PT', '')
                                        .replaceFirst('P1DT', '')
                                        .replaceFirst('P2DT', '') ??
                                    '',
                                arriveTime: convertTime(
                                  offer?.slices?[0].segments?[0].arrivingAt ??
                                      '',
                                ),
                                airLineName: offer?.owner?.name ?? '',
                                departDate: controller
                                    .formattedNullAbleStringDepartDateIndex(
                                  offer,
                                  0,
                                  0,
                                ),
                                onTap: () {},
                                price: offer?.baseAmount ?? '',
                                aitLineLogo: offer?.owner?.logoSymbolUrl ?? '',
                                arriveItaCode:
                                    offer?.slices?[0].destination?.iataCode ??
                                        '',
                                departItaCode:
                                    offer?.slices?[0].origin?.iataCode ?? '',
                                departTime: convertTime(
                                  offer?.slices?[0].segments?[0].departingAt ??
                                      '',
                                ),
                              ),
                              isOneWayTrip == false
                                  ? OneWayTripWidget(
                                      onTapFlightDetails: () {
                                        controller.onTapFlightDetails(
                                          offer: offer,
                                          classType: classType,
                                        );
                                      },
                                      duration: offer
                                              ?.slices?[1].segments?[0].duration
                                              ?.replaceFirst('PT', '')
                                              .replaceFirst('P1DT', '')
                                              .replaceFirst('P2DT', '') ??
                                          '',
                                      arriveTime: convertTime(
                                        offer?.slices?[1].segments?[0]
                                                .arrivingAt ??
                                            '',
                                      ),
                                      airLineName: offer?.owner?.name ?? '',
                                      departDate: controller
                                          .formattedNullAbleStringDepartDateIndex(
                                        offer,
                                        0,
                                        1,
                                      ),
                                      onTap: () {},
                                      price: offer?.baseAmount ?? '',
                                      aitLineLogo:
                                          offer?.owner?.logoSymbolUrl ?? '',
                                      arriveItaCode: offer?.slices?[1]
                                              .destination?.iataCode ??
                                          '',
                                      departItaCode:
                                          offer?.slices?[1].origin?.iataCode ??
                                              '',
                                      departTime: convertTime(
                                        offer?.slices?[1].segments?[0]
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
                          text: 'Contact Details',
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
                              top: 0.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                CommonPassengnerTextFormFilled(
                                  controller: controller.emailController.value,
                                  title: 'Email',
                                  hintText: 'Enter email',
                                ),
                                // IntlPhoneField(
                                //   decoration: InputDecoration(
                                //     labelText: 'Phone Number',
                                //     border: OutlineInputBorder(
                                //       borderSide: BorderSide(),
                                //     ),
                                //   ),
                                //   initialCountryCode: 'IN',
                                //   onChanged: (phone) {
                                //     print(phone.completeNumber);
                                //   },
                                // ),

                                CommonPassengnerTextFormFilled(
                                  textInputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(
                                      controller.phoneNumberLength.value,
                                    ),
                                  ],
                                  onChanged: (v) {},
                                  keyboardType: TextInputType.number,
                                  hintText: 'Enter phone number',
                                  controller:
                                      controller.phoneNumberController.value,
                                  onTapPrefixIcon: () {
                                    Get.to(() => CountryCodeScreen())
                                        ?.then((value) => controller.update());
                                  },
                                  prefixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        controller.countryFlag.value,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper
                                              .boldFont, // Replace with your FontHelper
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '+ ${controller.countryCode.value ?? ''}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontFamily: FontHelper
                                              .boldFont, // Replace with your FontHelper
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Container(
                                        height: 15.h,
                                        width: 1.w,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                    ],
                                  ),
                                  title: 'Phone Number',
                                ),

                                Text(
                                  'Passangers',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontFamily: FontHelper
                                        .boldFont, // Replace with your FontHelper
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: (Get.height * 0.95) *
                                      controller.adultList.length,
                                  child: ListView.builder(
                                    itemCount: controller.adultList.length,
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 2.h),
                                        height: Get.height * 0.95,
                                        width: Get.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 30.h,
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
                                                'Adult ${index + 1}',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                  fontFamily: FontHelper
                                                      .boldFont, // Replace with your FontHelper
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              'Personal Details',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.grey,
                                                fontFamily: FontHelper
                                                    .boldFont, // Replace with your FontHelper
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              suffixIcon:
                                                  ImageConstant.downArrow,
                                              readOnly: true,
                                              onTap: () {
                                                commonBottomSheet(
                                                  controller,
                                                  type: 'title',
                                                  onTapTitle: (v) {
                                                    controller
                                                        .adultControllerList[
                                                            index]
                                                        .titleController
                                                        ?.text = v.name ?? '';
                                                    Get.back();
                                                  },
                                                );
                                              },
                                              hintText: 'Select title',
                                              title: 'Title',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .titleController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              textInputFormatter: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp(
                                                    r'^[a-zA-Z ]+$',
                                                  ),
                                                ),
                                              ],
                                              hintText: 'Enter your name',
                                              title: 'Given Name',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .givenNameController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              textInputFormatter: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(
                                                  RegExp(
                                                    r'^[a-zA-Z ]+$',
                                                  ),
                                                ),
                                              ],
                                              hintText: 'Enter family name',
                                              title: 'Family Name',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .familyNameController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              readOnly: true,
                                              suffixIcon:
                                                  ImageConstant.dobCalenderIcon,
                                              hintText: 'Enter date of birth',
                                              title: 'Date of Birth',
                                              onTap: () {
                                                log('Child Tab');
                                                controller.selectDobDate(
                                                  context,
                                                  passangerType: 'adult',
                                                  index: index,
                                                  passangers: controller
                                                      .adultList[index],
                                                );
                                              },
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .dobController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              readOnly: true,
                                              hintText: 'Select gender',
                                              title: 'Gender',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .genderController,
                                              suffixIcon:
                                                  ImageConstant.downArrow,
                                              onTap: () {
                                                commonBottomSheet(
                                                  controller,
                                                  onTap: (v) {
                                                    controller
                                                        .adultControllerList[
                                                            index]
                                                        .genderController
                                                        ?.text = v;
                                                    Get.back();
                                                  },
                                                );
                                              },
                                            ),
                                            Text(
                                              'Passport Details',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.grey,
                                                fontFamily: FontHelper
                                                    .boldFont, // Replace with your FontHelper
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              readOnly: true,
                                              onTap: () {
                                                Get.to(
                                                  () => CountryCodeScreen(
                                                    passangerType: 'adult',
                                                    index: index,
                                                  ),
                                                )?.then(
                                                  (value) =>
                                                      controller.update(),
                                                );
                                              },
                                              hintText:
                                                  'Select country of issue',
                                              title: 'Country of Issue',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .issuedCountryController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              hintText: 'Enter passport number',
                                              title: 'Passport number',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .passportController,
                                            ),
                                            CommonPassengnerTextFormFilled(
                                              readOnly: true,
                                              onTap: () {
                                                controller.selectExpiaryDate(
                                                  passangerType: 'adult',
                                                  context,
                                                  index: index,
                                                );
                                              },
                                              hintText: 'Select expiary date',
                                              title: 'Expiry Date',
                                              controller: controller
                                                  .adultControllerList[index]
                                                  .expiaryDateController,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: controller.childList.isNotEmpty,
                                  child: SizedBox(
                                    height: (Get.height * 0.95) *
                                        controller.childList.length,
                                    child: ListView.builder(
                                      itemCount: controller.childList.length,
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          height: Get.height * 0.95,
                                          width: Get.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 30.h,
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
                                                  'Child ${i + 1}',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontFamily: FontHelper
                                                        .boldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                'Personal Details',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey,
                                                  fontFamily: FontHelper
                                                      .boldFont, // Replace with your FontHelper
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                suffixIcon:
                                                    ImageConstant.downArrow,
                                                readOnly: true,
                                                onTap: () {
                                                  commonBottomSheet(
                                                    controller,
                                                    type: 'title',
                                                    onTapTitle: (v) {
                                                      controller
                                                          .childControllerList[
                                                              i]
                                                          .titleController
                                                          ?.text = v.name ?? '';
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                hintText: 'Enter title',
                                                title: 'Title',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .titleController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                textInputFormatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r'^[a-zA-Z ]+$',
                                                    ),
                                                  ),
                                                ],
                                                hintText: 'Given name',
                                                title: 'Given Name',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .givenNameController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                textInputFormatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r'^[a-zA-Z ]+$',
                                                    ),
                                                  ),
                                                ],
                                                hintText: 'Enter family name',
                                                title: 'Family Name',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .familyNameController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                suffixIcon: ImageConstant
                                                    .dobCalenderIcon,
                                                readOnly: true,
                                                onTap: () {
                                                  log('Child Tab');
                                                  controller.selectDobDate(
                                                    passangerType: 'child',
                                                    context,
                                                    index: i,
                                                    passangers:
                                                        controller.childList[i],
                                                  );
                                                },
                                                hintText: 'Enter date of birth',
                                                title: 'Date of Birth',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .dobController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  commonBottomSheet(
                                                    controller,
                                                    onTap: (v) {
                                                      controller
                                                          .childControllerList[
                                                              i]
                                                          .genderController
                                                          ?.text = v;

                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                hintText: 'Select gender',
                                                title: 'Gender',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .genderController,
                                                suffixIcon:
                                                    ImageConstant.downArrow,
                                              ),
                                              Text(
                                                'Passport Details',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey,
                                                  fontFamily: FontHelper
                                                      .boldFont, // Replace with your FontHelper
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  Get.to(
                                                    () => CountryCodeScreen(
                                                      passangerType: 'child',
                                                      index: i,
                                                    ),
                                                  )?.then(
                                                    (value) =>
                                                        controller.update(),
                                                  );
                                                },
                                                hintText:
                                                    'Select country of issue',
                                                title: 'Country of Issue',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .issuedCountryController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                hintText:
                                                    'Enter passport number',
                                                title: 'Passport number',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .passportController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  log('Child Tab');

                                                  controller.selectExpiaryDate(
                                                    passangerType: 'child',
                                                    context,
                                                    index: i,
                                                  );
                                                },
                                                hintText: 'Select expiary date',
                                                title: 'Expiry Date',
                                                controller: controller
                                                    .childControllerList[i]
                                                    .expiaryDateController,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.infantList.isNotEmpty,
                                  child: SizedBox(
                                    height: (Get.height * 0.95) *
                                        controller.infantList.length,
                                    child: ListView.builder(
                                      itemCount: controller.infantList.length,
                                      padding: const EdgeInsets.all(0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          height: Get.height * 0.95,
                                          width: Get.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 30.h,
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
                                                  'Infant ${i + 1}',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontFamily: FontHelper
                                                        .boldFont, // Replace with your FontHelper
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                'Personal Details',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey,
                                                  fontFamily: FontHelper
                                                      .boldFont, // Replace with your FontHelper
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                suffixIcon:
                                                    ImageConstant.downArrow,
                                                readOnly: true,
                                                onTap: () {
                                                  commonBottomSheet(
                                                    controller,
                                                    type: 'title',
                                                    onTapTitle: (v) {
                                                      controller
                                                          .infantControllerList[
                                                              i]
                                                          .titleController
                                                          ?.text = v.name ?? '';
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                hintText: 'Enter title',
                                                title: 'Title',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .titleController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                textInputFormatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r'^[a-zA-Z ]+$',
                                                    ),
                                                  ),
                                                ],
                                                hintText: 'Given name',
                                                title: 'Given Name',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .givenNameController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                textInputFormatter: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                      r'^[a-zA-Z ]+$',
                                                    ),
                                                  ),
                                                ],
                                                hintText: 'Enter family name',
                                                title: 'Family Name',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .familyNameController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                suffixIcon: ImageConstant
                                                    .dobCalenderIcon,
                                                readOnly: true,
                                                onTap: () {
                                                  controller.selectDobDate(
                                                    passangerType: 'infant',
                                                    context,
                                                    index: i,
                                                    passangers: controller
                                                        .infantList[i],
                                                  );
                                                },
                                                hintText: 'Enter date of birth',
                                                title: 'Date of Birth',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .dobController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  commonBottomSheet(
                                                    controller,
                                                    onTap: (v) {
                                                      controller
                                                          .infantControllerList[
                                                              i]
                                                          .genderController
                                                          ?.text = v;

                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                hintText: 'Select gender',
                                                title: 'Gender',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .genderController,
                                                suffixIcon:
                                                    ImageConstant.downArrow,
                                              ),
                                              Text(
                                                'Passport Details',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.grey,
                                                  fontFamily: FontHelper
                                                      .boldFont, // Replace with your FontHelper
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  Get.to(
                                                    () => CountryCodeScreen(
                                                      passangerType: 'infant',
                                                      index: i,
                                                    ),
                                                  )?.then(
                                                    (value) =>
                                                        controller.update(),
                                                  );
                                                },
                                                hintText:
                                                    'Select country of issue',
                                                title: 'Country of Issue',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .issuedCountryController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                hintText:
                                                    'Enter passport number',
                                                title: 'Passport number',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .passportController,
                                              ),
                                              CommonPassengnerTextFormFilled(
                                                readOnly: true,
                                                onTap: () {
                                                  controller.selectExpiaryDate(
                                                    passangerType: 'infant',
                                                    context,
                                                    index: i,
                                                  );
                                                },
                                                hintText: 'Select expiary date',
                                                title: 'Expiry Date',
                                                controller: controller
                                                    .infantControllerList[i]
                                                    .expiaryDateController,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
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
                      () => controller.isLoading.value == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                controller.onTapContinue(
                                  offer: offer,
                                  isOneWayTrip: isOneWayTrip,
                                  classType: classType,
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
                                  'Continue',
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

  Future commonBottomSheet(
    PassangerContactDetailController controller, {
    Function(String)? onTap,
    Function(TitleModal)? onTapTitle,
    String? type,
  }) {
    return Get.bottomSheet(
      Container(
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
                SizedBox(
                  width: 35.w,
                ),
                Text(
                  type == 'title' ? 'Select title' : 'Select Gender',
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
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: type == 'title'
                    ? controller.titleList.length
                    : controller.genderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      type == 'title'
                          ? onTapTitle != null
                              ? onTapTitle(
                                  TitleModal(
                                    title:
                                        controller.titleList[index].title ?? '',
                                    name:
                                        controller.titleList[index].name ?? '',
                                  ),
                                )
                              : null
                          : onTap != null
                              ? onTap(controller.genderList[index])
                              : null;
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          type == 'title'
                              ? controller.titleList[index].name
                              : controller.genderList[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontFamily: FontHelper
                                .boldFont, // Replace with your FontHelper
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
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
              totalTime: duration
                      ?.replaceFirst('PT', '')
                      .replaceFirst('P1DT', '')
                      .replaceFirst('P2DT', '') ??
                  '',
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
