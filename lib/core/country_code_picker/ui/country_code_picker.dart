import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../presentation/flights/passenger_contact_detail/controller/passenger_contact_details_controller.dart';
import '../../font_helper/font_helper.dart';
import '../country_code_json_list.dart';
import '../modal/country_modal.dart';

class CountryCodeScreen extends StatefulWidget {
  String? passangerType;
  Function(Country)? onTapItem;
  int? index;
  CountryCodeScreen(
      {super.key, this.onTapItem, this.index, this.passangerType});

  @override
  State<CountryCodeScreen> createState() => _CountryCodeScreenState();
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  TextEditingController countryController = TextEditingController();
  List<Country> countryCodeList = [];
  List<Country> dummyCountryCodeList = [];

  onChangedList(String v) {
    if (v.isNotEmpty) {
      dummyCountryCodeList = countryCodeList.where((element) {
        log(element.name.toString());
        log(v.toString());
        return element.name.toString().toLowerCase().contains(v.toLowerCase());
      }).toList();
      log(dummyCountryCodeList.length.toString());
    } else {
      log(countryCodeList.length.toString());
      dummyCountryCodeList = countryCodeList;
    }
    setState(() {});
  }

  getDataList() async {
    dummyCountryCodeList.clear();
    countryCodeList = countryCodes.map((e) => Country.fromMap(e)).toList();
    dummyCountryCodeList.addAll(countryCodeList);
  }

  static String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  @override
  void initState() {
    super.initState();
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 50.h,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: FontHelper.boldFont,
                ),
                onChanged: (v) {
                  log(v.toString());
                  onChangedList(v);
                },
                controller: countryController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontFamily: FontHelper.boldFont,
                  ),
                  hintText: 'Search by country name...',
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Select your country',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontFamily: FontHelper.boldFont,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: dummyCountryCodeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        if (widget.index != null) {
                          if (Get.find<PassangerContactDetailController>()
                                  .infantControllerList
                                  .isNotEmpty &&
                              widget.passangerType == 'infant') {
                            Get.find<PassangerContactDetailController>()
                                    .infantControllerList[widget.index ?? 0]
                                    .issuedCountryController
                                    ?.text =
                                dummyCountryCodeList[index].countryCode ?? '';
                          } else if (Get.find<
                                      PassangerContactDetailController>()
                                  .childControllerList
                                  .isNotEmpty &&
                              widget.passangerType == 'child') {
                            Get.find<PassangerContactDetailController>()
                                    .childControllerList[widget.index ?? 0]
                                    .issuedCountryController
                                    ?.text =
                                dummyCountryCodeList[index].countryCode ?? '';
                          } else if (Get.find<
                                      PassangerContactDetailController>()
                                  .adultControllerList
                                  .isNotEmpty &&
                              widget.passangerType == 'adult') {
                            Get.find<PassangerContactDetailController>()
                                    .adultControllerList[widget.index ?? 0]
                                    .issuedCountryController
                                    ?.text =
                                dummyCountryCodeList[index].countryCode ?? '';
                          }
                        } else {
                          Get.find<PassangerContactDetailController>()
                                  .countryCode
                                  .value =
                              dummyCountryCodeList[index].phoneCode ?? '';
                          Get.find<PassangerContactDetailController>()
                              .countryFlag
                              .value = countryCodeToEmoji(
                            dummyCountryCodeList[index].countryCode ?? '',
                          );
                          Get.find<PassangerContactDetailController>()
                                  .phoneNumberLength
                                  .value =
                              dummyCountryCodeList[index].phoneNumberLength ??
                                  10;
                        }
                        log('phoneNumberLength==${dummyCountryCodeList[index].phoneNumberLength}');
                        // Get.find<GetStorageController>().setCountryCode(
                        //     dummyCountryCodeList[index].phoneCode ?? '');
                        // Get.find<GetStorageController>().setCountryFlag(
                        //     countryCodeToEmoji(
                        //         dummyCountryCodeList[index].countryCode ?? ''));
                        // Get.find<AuthorizationController>()
                        //         .flagController
                        //         .text =
                        //     countryCodeToEmoji(
                        //         dummyCountryCodeList[index].countryCode ?? '');
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    countryCodeToEmoji(
                                        dummyCountryCodeList[index]
                                                .countryCode ??
                                            ''),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dummyCountryCodeList[index].name ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '+${dummyCountryCodeList[index].phoneCode}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontFamily: FontHelper.boldFont,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Divider()
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
