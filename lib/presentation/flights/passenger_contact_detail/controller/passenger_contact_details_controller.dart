import 'dart:developer';

import 'package:airline_booking/presentation/flights/modal/flight_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../booking_detail/ui/booking_detail.dart';
import '../modal/passanger_contact_detail_modal.dart';

class PassangerContactDetailController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  RxList<ControllerModal> adultControllerList = <ControllerModal>[].obs;
  RxList<ControllerModal> childControllerList = <ControllerModal>[].obs;
  RxList<ControllerModal> infantControllerList = <ControllerModal>[].obs;
  RxInt phoneNumberLength = 10.obs;

  RxList genderList = [
    'Male',
    'Female',
  ].obs;
  RxList<TitleModal> titleList = <TitleModal>[
    TitleModal(title: 'mr', name: 'Mr'),
    TitleModal(title: 'ms', name: 'Ms'),
    TitleModal(title: 'mrs', name: 'Mrs'),
    TitleModal(title: 'miss', name: 'Miss'),
    TitleModal(title: 'dr', name: 'Dr'),
  ].obs;
  List<Passengers> childList = [];
  List<Passengers> adultList = [];
  List<Passengers> infantList = [];
  RxBool isLoading = false.obs;

  getAirLineStops() {}

  genRateControllers(List<Passengers> passengersList) {
    adultControllerList.value = List.generate(
      adultList.length,
      (index) => ControllerModal(
        titleController: TextEditingController(),
        dobController: TextEditingController(),
        expiaryDateController: TextEditingController(),
        familyNameController: TextEditingController(),
        genderController: TextEditingController(),
        givenNameController: TextEditingController(),
        issuedCountryController: TextEditingController(),
        passportController: TextEditingController(),
      ),
    );

    childControllerList.value = List.generate(
      childList.length,
      (index) => ControllerModal(
        titleController: TextEditingController(),
        dobController: TextEditingController(),
        expiaryDateController: TextEditingController(),
        familyNameController: TextEditingController(),
        genderController: TextEditingController(),
        givenNameController: TextEditingController(),
        issuedCountryController: TextEditingController(),
        passportController: TextEditingController(),
      ),
    );
    infantControllerList.value = List.generate(
      infantList.length,
      (index) => ControllerModal(
        titleController: TextEditingController(),
        dobController: TextEditingController(),
        expiaryDateController: TextEditingController(),
        familyNameController: TextEditingController(),
        genderController: TextEditingController(),
        givenNameController: TextEditingController(),
        issuedCountryController: TextEditingController(),
        passportController: TextEditingController(),
      ),
    );
  }

  List<Passengers>? passengerList = [];

  RxList<PassengerModal> selectedPassengerList = <PassengerModal>[].obs;
  RxList<IdentityDocuments> identityList = <IdentityDocuments>[].obs;

  RxString countryCode = '91'.obs;
  RxString countryFlag = ''.obs;

  String offerId = '';
  FlightDataModal allFlightData = FlightDataModal();
  PassangerContactDetailController({required this.offerId, this.passengerList});

  String formattedNullAbleStringDepartDateIndex(
    Offers? offers,
    int index,
    int sliceIndex,
  ) {
    if (offers != null &&
        offers.slices != null &&
        offers.slices!.isNotEmpty &&
        offers.slices?[sliceIndex].segments != null &&
        offers.slices![sliceIndex].segments!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].departingAt != null) {
      return dateFormatString(
        offers.slices?[sliceIndex].segments?[0].departingAt ?? '',
      );
    }
    return '';
  }

  String formattedNullAbleStringArriveDateIndex(
    Offers? offers,
    int index,
    int sliceIndex,
  ) {
    if (offers != null &&
        offers.slices != null &&
        offers.slices!.isNotEmpty &&
        offers.slices?[sliceIndex].segments != null &&
        offers.slices![sliceIndex].segments!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].departingAt != null) {
      return dateFormatString(
        offers.slices?[sliceIndex].segments?[0].arrivingAt ?? '',
      );
    }
    return '';
  }

  String carryOnBagCount(Offers? offers, int sliceIndex) {
    if (offers != null &&
        offers.slices != null &&
        offers.slices!.isNotEmpty &&
        offers.slices![sliceIndex].segments != null &&
        offers.slices![sliceIndex].segments!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].passengers != null &&
        offers.slices![sliceIndex].segments![0].passengers!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].passengers![0].baggages !=
            null &&
        offers.slices![sliceIndex].segments![0].passengers![0].baggages!
            .isNotEmpty) {
      return offers.slices?[sliceIndex].segments?[0].passengers?[0].baggages?[1]
              .quantity
              .toString() ??
          '';
    }
    return '';
  }

  String checkedBagCount(Offers? offers, int sliceIndex) {
    // controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
    //     .segments?[0].passengers[0].baggages[0].quantity.toString()

    if (offers != null &&
        offers.slices != null &&
        offers.slices!.isNotEmpty &&
        offers.slices![sliceIndex].segments != null &&
        offers.slices![sliceIndex].segments!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].passengers != null &&
        offers.slices![sliceIndex].segments![0].passengers!.isNotEmpty &&
        offers.slices?[sliceIndex].segments?[0].passengers![0].baggages !=
            null &&
        offers.slices![sliceIndex].segments![0].passengers![0].baggages!
            .isNotEmpty) {
      return offers.slices?[sliceIndex].segments?[0].passengers?[0].baggages?[0]
              .quantity
              .toString() ??
          '';
    }
    return '';
  }

  onTapFlightDetails({Offers? offer, String? classType}) {
    flightDetailsBottomSheet(
      classType: classType == 'economy'
          ? 'Economy'
          : classType == 'first'
              ? 'First Class'
              : classType == 'premium_economy'
                  ? 'Premium Economy'
                  : 'Business',
      airLineName: offer?.owner?.name ?? '',
      arriveDate: formattedNullAbleStringArriveDateIndex(
        offer,
        0,
        0,
      ),
      arriveTime: convertTime(
        offer?.slices?[0].segments?[0].arrivingAt ?? '',
      ),
      carryBagCount: carryOnBagCount(
        offer,
        0,
      ),
      checkedBagCount: checkedBagCount(
        offer,
        0,
      ),
      departureDate: formattedNullAbleStringDepartDateIndex(
        offer,
        0,
        0,
      ),
      departureTime: convertTime(
        offer?.slices?[0].segments?[0].departingAt ?? '',
      ),
      destinationItaCode: offer?.slices?[0].destination?.iataCode ?? '',
      destinationLocation:
          '${offer?.slices?[0].destination?.cityName ?? ''} (${offer?.slices?[0].destination?.iataCityCode ?? ''})',
      duration: offer?.slices?[0].segments?[0].duration
              ?.replaceFirst('PT', '')
              .replaceFirst('P1DT', '')
              .replaceFirst('P2DT', '') ??
          '',
      originItaCode: offer?.slices?[0].origin?.iataCode ?? '',
      originLocation:
          '${offer?.slices?[0].origin?.cityName ?? ''} (${offer?.slices?[0].origin?.iataCityCode ?? ''})',
    );
  }

  @override
  void onInit() {
    super.onInit();
    // getSingleOffer();
    getPassangersData();
    genRateControllers(passengerList ?? []);
  }

  getPassangersData() {
    infantList.clear();
    childList.clear();
    adultList.clear();
    if (passengerList != null && passengerList!.isNotEmpty) {
      for (var i in passengerList!) {
        if (i.age != null && i.age! > 2) {
          childList.add(i);
        } else if (i.age != null && i.age! <= 2) {
          infantList.add(i);
        } else if (i.age == null) {
          adultList.add(i);
        }
      }
    }
  }

  int adultListLength(List<Passengers> passengerList) {
    int count = 0;
    if (passengerList.isNotEmpty) {
      for (var i in passengerList) {
        log(i.type.toString());
        if (i.type == 'adult') {
          count = count + 1;
          log(count.toString());
        }
      }
    }
    log('Length ===$count');
    return count;
  }

  int childListLength(List<Passengers> passengerList) {
    int count = 0;
    if (passengerList.isNotEmpty) {
      for (var i in passengerList) {
        log(i.type.toString());
        if (i.age != null && i.age! > 2) {
          count = count + 1;
          log(count.toString());
        }
      }
    }
    log('Child count$count');
    return count;
  }

  int infantListLength(List<Passengers> passengerList) {
    int count = 0;
    if (passengerList.isNotEmpty) {
      for (var i in passengerList) {
        log(i.type.toString());
        if (i.age != null && i.age! <= 2) {
          count = count + 1;
          log(count.toString());
        }
      }
    }
    log('Child count$count');
    return count;
  }

  onTapContinue({Offers? offer, bool? isOneWayTrip, String? classType}) {
    log('message');
    if (!GetUtils.isEmail(emailController.value.text) ||
        emailController.value.text.isEmpty) {
      CustomToast.showToast('Please enter your valid email');
    } else if (phoneNumberController.value.text.isEmpty ||
        phoneNumberLength.value != phoneNumberController.value.text.length) {
      CustomToast.showToast('Please enter valid mobile no');
    } else if (countryFlag.value == '') {
      CustomToast.showToast('Please select phone number country code');
    } else if (adultControllerList.any(
      (element) => (element.titleController != null &&
          element.titleController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please enter adult title');
    } else if (adultControllerList.any(
      (element) => (element.givenNameController != null &&
          element.givenNameController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please enter adult given name');
    } else if (adultControllerList.any(
      (element) => (element.familyNameController != null &&
          element.familyNameController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please enter adult family name');
    } else if (adultControllerList.any(
      (element) => (element.dobController != null &&
          element.dobController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please select adult date of birth');
    } else if (adultControllerList.any(
      (element) => (element.genderController != null &&
          element.genderController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please select adult gender');
    } else if (adultControllerList.any(
      (element) => (element.passportController != null &&
          element.passportController!.text.isEmpty),
    )) {
      CustomToast.showToast('Please enter adult passport number');
    } else if (adultControllerList.any((element) =>
        (element.expiaryDateController != null &&
            element.expiaryDateController!.text.isEmpty))) {
      CustomToast.showToast('Please select adult passport expiary date');
    } else if (childControllerList.isNotEmpty ||
        infantControllerList.isNotEmpty) {
      if (childControllerList.isNotEmpty &&
          childControllerList.any(
            (element) => (element.titleController != null &&
                element.titleController!.text.isEmpty),
          )) {
        CustomToast.showToast('Please enter child title');
      } else if (childControllerList.any(
        (element) => (element.givenNameController != null &&
            element.givenNameController!.text.isEmpty),
      )) {
        CustomToast.showToast('Please enter child given name');
      } else if (childControllerList.any(
        (element) => (element.familyNameController != null &&
            element.familyNameController!.text.isEmpty),
      )) {
        CustomToast.showToast('Please enter child family name');
      } else if (childControllerList.any(
        (element) => (element.dobController != null &&
            element.dobController!.text.isEmpty),
      )) {
        CustomToast.showToast('Please select child date of birth');
      } else if (childControllerList.any(
        (element) => (element.genderController != null &&
            element.genderController!.text.isEmpty),
      )) {
        CustomToast.showToast('Please select child gender');
      } else if (childControllerList.any(
        (element) => (element.passportController != null &&
            element.passportController!.text.isEmpty),
      )) {
        CustomToast.showToast('Please enter child passport number');
      } else if (childControllerList.any((element) =>
          (element.expiaryDateController != null &&
              element.expiaryDateController!.text.isEmpty))) {
        CustomToast.showToast('Please select child passport expiary date');
      } else if (infantControllerList.isNotEmpty) {
        if (infantControllerList.any(
          (element) => (element.titleController != null &&
              element.titleController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please enter infant title');
        } else if (infantControllerList.any(
          (element) => (element.givenNameController != null &&
              element.givenNameController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please enter infant given name');
        } else if (infantControllerList.any(
          (element) => (element.familyNameController != null &&
              element.familyNameController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please enter infant family name');
        } else if (infantControllerList.any(
          (element) => (element.dobController != null &&
              element.dobController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please select infant date of birth');
        } else if (infantControllerList.any(
          (element) => (element.genderController != null &&
              element.genderController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please select infant gender');
        } else if (infantControllerList.any(
          (element) => (element.passportController != null &&
              element.passportController!.text.isEmpty),
        )) {
          CustomToast.showToast('Please enter infant passport number');
        } else if (infantControllerList.any((element) =>
            (element.expiaryDateController != null &&
                element.expiaryDateController!.text.isEmpty))) {
          CustomToast.showToast('Please select infant passport expiary date');
        } else {
          bodyData();
          List<String> selectedOffer = [offer?.id ?? ''];
          List<Payments> payments = [
            Payments(
              type: 'balance',
              amount: offer?.totalAmount ?? '',
              currency: offer?.baseCurrency ?? '',
            ),
          ];

          Get.to(
            () => BookingDetailScreen(
              bookingDetail: offer,
              payments: payments,
              passangerList: selectedPassengerList,
              isOneWayTrip: isOneWayTrip,
              classType: classType,
            ),
          );
        }
      } else {
        bodyData();
        List<String> selectedOffer = [offer?.id ?? ''];
        List<Payments> payments = [
          Payments(
            type: 'balance',
            amount: offer?.totalAmount ?? '',
            currency: offer?.baseCurrency ?? '',
          ),
        ];

        Get.to(
          () => BookingDetailScreen(
            bookingDetail: offer,
            payments: payments,
            passangerList: selectedPassengerList,
            isOneWayTrip: isOneWayTrip,
            classType: classType,
          ),
        );
      }
    } else {
      bodyData();
      List<String> selectedOffer = [offer?.id ?? ''];
      List<Payments> payments = [
        Payments(
          type: 'balance',
          amount: offer?.totalAmount ?? '',
          currency: offer?.baseCurrency ?? '',
        ),
      ];

      Get.to(
        () => BookingDetailScreen(
          bookingDetail: offer,
          payments: payments,
          passangerList: selectedPassengerList,
          isOneWayTrip: isOneWayTrip,
          classType: classType,
        ),
      );
    }
  }

  bodyData() {
    isLoading.value = true;
    identityList.clear();
    selectedPassengerList.clear();
    if (adultList.isNotEmpty) {
      for (var i = 0; i < adultList.length; i++) {
        identityList.add(
          IdentityDocuments(
            type: 'passport',
            countryCode:
                adultControllerList[i].issuedCountryController?.text.trim() ??
                    '',
            expireOn:
                adultControllerList[i].expiaryDateController?.text.trim() ?? '',
            passportNo:
                adultControllerList[i].passportController?.text.trim() ?? '',
          ),
        );
        selectedPassengerList.add(
          PassengerModal(
            type: 'adult',
            title: adultControllerList[i].titleController?.text.trim() ?? '',
            email: emailController.value.text,
            bornOn: adultControllerList[i].dobController?.text.trim() ?? '',
            familyName:
                adultControllerList[i].familyNameController?.text.trim() ?? '',
            gender: adultControllerList[i]
                    .genderController
                    ?.text
                    .trim()
                    .substring(0, 1)
                    .toLowerCase() ??
                ''.substring(0, 1).toLowerCase(),
            givenName:
                adultControllerList[i].givenNameController?.text.trim() ?? '',
            id: adultList?[i].id ?? '',
            identityDocuments: identityList.map((element) => element).toList(),
            mobileNo:
                '+${countryCode.value} ${phoneNumberController.value.text}',
          ),
        );
        if (passengerList!.length >= 2) {
          identityList.removeAt(0);
        }

        log('kkkkk${selectedPassengerList[i].identityDocuments?.length}');
      }
    }

    if (childList.isNotEmpty) {
      for (var i = 0; i < childList.length; i++) {
        identityList.add(
          IdentityDocuments(
            type: 'passport',
            countryCode:
                childControllerList[i].issuedCountryController?.text.trim() ??
                    '',
            expireOn:
                childControllerList[i].expiaryDateController?.text.trim() ?? '',
            passportNo:
                childControllerList[i].passportController?.text.trim() ?? '',
          ),
        );
        selectedPassengerList.add(
          PassengerModal(
            type: 'child',
            title: childControllerList[i].titleController?.text.trim() ?? '',
            email: emailController.value.text,
            bornOn: childControllerList[i].dobController?.text.trim() ?? '',
            familyName:
                childControllerList[i].familyNameController?.text.trim() ?? '',
            gender: childControllerList[i]
                    .genderController
                    ?.text
                    .trim()
                    .substring(0, 1)
                    .toLowerCase() ??
                ''.substring(0, 1).toLowerCase(),
            givenName:
                childControllerList[i].givenNameController?.text.trim() ?? '',
            id: childList?[i].id ?? '',
            identityDocuments: identityList.map((element) => element).toList(),
            mobileNo:
                '+${countryCode.value} ${phoneNumberController.value.text}',
          ),
        );
        if (passengerList!.length >= 2) {
          identityList.removeAt(0);
        }

        log('kkkkk${selectedPassengerList[i].identityDocuments?.length}');
      }
    }

    if (infantList.isNotEmpty) {
      for (var i = 0; i < infantList.length; i++) {
        identityList.add(
          IdentityDocuments(
            type: 'passport',
            countryCode:
                infantControllerList[i].issuedCountryController?.text.trim() ??
                    '',
            expireOn:
                infantControllerList[i].expiaryDateController?.text.trim() ??
                    '',
            passportNo:
                infantControllerList[i].passportController?.text.trim() ?? '',
          ),
        );
        selectedPassengerList.add(
          PassengerModal(
            type: 'infant',
            title: infantControllerList[i].titleController?.text.trim() ?? '',
            email: emailController.value.text,
            bornOn: infantControllerList[i].dobController?.text.trim() ?? '',
            familyName:
                infantControllerList[i].familyNameController?.text.trim() ?? '',
            gender: infantControllerList[i]
                    .genderController
                    ?.text
                    .trim()
                    .substring(0, 1)
                    .toLowerCase() ??
                ''.substring(0, 1).toLowerCase(),
            givenName:
                infantControllerList[i].givenNameController?.text.trim() ?? '',
            id: infantList[i].id ?? '',
            identityDocuments: identityList.map((element) => element).toList(),
            mobileNo:
                '+${countryCode.value} ${phoneNumberController.value.text}',
          ),
        );
        if (passengerList!.length >= 2) {
          identityList.removeAt(0);
        }

        log('kkkkk${selectedPassengerList[i].identityDocuments?.length}');
      }
    }
    isLoading.value = false;
  }

  // createAirlineOffer({
  //   List<String>? selectedOffers,
  //   List<Payments>? payments,
  // }) async {
  //   var data = {
  //     'data': {
  //       'selected_offers': selectedOffers,
  //       'payments': payments?.map((e) => e.toJson()).toList(),
  //       'passengers':
  //           selectedPassengerList.value.map((item) => item.toJson()).toList(),
  //     },
  //   };
  //   log(data.toString());
  //   var response = await ApiCall.httpPostAPi(
  //     data: data,
  //     endPoint: ApiConstant.createOrders,
  //     token: DuffelConstantValue.duffelToken,
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data =
  //         bookingDetail.BookingDetailModal.fromJson(jsonDecode(response.body));
  //     Get.to(
  //       () => BookingDetailScreen(
  //         bookingDetail: data,
  //       ),
  //     );
  //   }
  // }

  selectDobDate(
    BuildContext context, {
    required int index,
    Passengers? passangers,
    String? passangerType,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (passangerType == 'adult' &&
              adultControllerList[index].dobController != null &&
              adultControllerList[index].dobController!.text.trim().isNotEmpty)
          ? DateTime.parse(adultControllerList[index].dobController!.text)
          : (passangerType == 'child' &&
                  childControllerList[index].dobController != null &&
                  childControllerList[index]
                      .dobController!
                      .text
                      .trim()
                      .isNotEmpty)
              ? DateTime.parse(childControllerList[index].dobController!.text)
              : (passangerType == 'infant' &&
                      infantControllerList[index].dobController != null &&
                      infantControllerList[index]
                          .dobController!
                          .text
                          .trim()
                          .isNotEmpty)
                  ? DateTime.parse(
                      infantControllerList[index].dobController!.text,
                    )
                  : (passangerType == 'adult' &&
                          adultControllerList[index]
                              .dobController!
                              .text
                              .trim()
                              .isEmpty)
                      ? DateTime(DateTime.now().year - 12)
                      : (passangerType == 'child' &&
                              childControllerList[index]
                                  .dobController!
                                  .text
                                  .trim()
                                  .isEmpty)
                          ? DateTime.now()
                          : DateTime.now(),
      firstDate: passangerType == 'adult'
          ? DateTime(1900)
          : passangerType == 'child'
              ? DateTime(DateTime.now().year - 12)
              : DateTime(DateTime.now().year - 2),
      lastDate: passangerType == 'adult'
          ? DateTime(DateTime.now().year - 12)
          : passangerType == 'child'
              ? DateTime.now()
              : DateTime.now(),
    );
    if (picked != null) {
      if (passangerType == 'adult') {
        adultControllerList[index].dobController?.text = dateFormat(picked);
      }

      if (passangerType == 'child' &&
          childList[index].age != (DateTime.now().year - picked.year)) {
        CustomToast.showToast(
          'Please ensure that child must me ${childList[index].age} year old',
        );
      } else if (passangerType == 'child') {
        childControllerList[index].dobController?.text = dateFormat(picked);
      }
      if (passangerType == 'infant' &&
          infantList[index].age != (DateTime.now().year - picked.year)) {
        CustomToast.showToast(
          'Please ensure that infant must me ${infantList[index].age} year old',
        );
      } else if (passangerType == 'infant') {
        infantControllerList[index].dobController?.text = dateFormat(picked);
      }
    }
    update();
  }

  selectExpiaryDate(
    BuildContext context, {
    required int index,
    Passengers? passangers,
    String? passangerType,
  }) async {
    log('Index=== ${index.toString()}');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (passangerType == 'adult' &&
              adultControllerList[index].expiaryDateController != null &&
              adultControllerList[index]
                  .expiaryDateController!
                  .text
                  .trim()
                  .isNotEmpty)
          ? DateTime.parse(
              adultControllerList[index].expiaryDateController!.text,
            )
          : (passangerType == 'child' &&
                  childControllerList[index].expiaryDateController != null &&
                  childControllerList[index]
                      .expiaryDateController!
                      .text
                      .trim()
                      .isNotEmpty)
              ? DateTime.parse(
                  childControllerList[index].expiaryDateController!.text,
                )
              : (passangerType == 'infant' &&
                      infantControllerList[index].expiaryDateController !=
                          null &&
                      infantControllerList[index]
                          .expiaryDateController!
                          .text
                          .trim()
                          .isNotEmpty)
                  ? DateTime.parse(
                      infantControllerList[index].expiaryDateController!.text,
                    )
                  : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (picked != null) {
      if (passangerType == 'adult') {
        adultControllerList[index].expiaryDateController?.text =
            dateFormat(picked);
      } else if (passangerType == 'child') {
        childControllerList[index].expiaryDateController?.text =
            dateFormat(picked);
      } else if (passangerType == 'infant') {
        infantControllerList[index].expiaryDateController?.text =
            dateFormat(picked);
      }
    }
    update();
  }

  String adultOrChild(String dateString) {
    DateTime date = DateTime.parse(dateString);

    DateTime twelveYearsAgo =
        DateTime.now().subtract(const Duration(days: 12 * 365));

    if (date.isBefore(twelveYearsAgo)) {
      return 'adult';
    } else {
      return 'child';
    }
  }
}

class ControllerModal {
  TextEditingController? titleController;
  TextEditingController? givenNameController;
  TextEditingController? familyNameController;
  TextEditingController? dobController;
  TextEditingController? genderController;
  TextEditingController? issuedCountryController;
  TextEditingController? passportController;
  TextEditingController? expiaryDateController;
  ControllerModal({
    this.titleController,
    this.dobController,
    this.expiaryDateController,
    this.familyNameController,
    this.genderController,
    this.givenNameController,
    this.issuedCountryController,
    this.passportController,
  });
}
