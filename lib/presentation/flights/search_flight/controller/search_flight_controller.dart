import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/api_call/api_call.dart';
import '../../../../core/api_constant/api_contants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../flights/ui/flights_screen.dart';
import '../../modal/error_modal.dart';
import '../../modal/flight_detail_modal.dart' as flightModal;
import '../modal/airport_suggestion_modal.dart';
import '../modal/search_flight_modal.dart';

class SearchFlightController extends GetxController {
  RxBool isOneWaySelected = true.obs;
  RxInt selectedAdultIndex = 0.obs;
  RxInt selectedAdultValue = 1.obs;
  RxInt selectedChildrenValue = 2.obs;
  RxInt selectedChildrenIndex = 2.obs;
  RxString totalTravelers = ''.obs;
  RxString originAirportLocation = ''.obs;
  RxString destinationAirportLocation = ''.obs;
  RxString classValue = 'Economy'.obs;
  RxString classSelectedValue = 'economy'.obs;
  RxList<SelectChildrenAge> childrenAgeList = <SelectChildrenAge>[].obs;
  Rx<TextEditingController> originController = TextEditingController().obs;
  Rx<TextEditingController> destinationController = TextEditingController().obs;
  RxString departureDate = ''.obs;
  RxString returnDate = ''.obs;
  RxList<PassengerModal> passengerList = <PassengerModal>[].obs;
  RxList<Slices> sliceList = <Slices>[].obs;
  RxList<ClassModal> flightClassList = <ClassModal>[
    ClassModal(text: 'Economy', isSelected: true, type: 'economy'),
    ClassModal(
        text: 'Premium Economy', isSelected: false, type: 'premium_economy'),
    ClassModal(text: 'Business', isSelected: false, type: 'business'),
    ClassModal(text: 'First Class', isSelected: false, type: 'first'),
  ].obs;
  RxBool isLoading = false.obs;

  RxList<Data> airPortSuggestionList = <Data>[].obs;

  onTapClassItems(int index) {
    if (flightClassList[index].isSelected == true) {
      flightClassList[index].isSelected = false;
    } else {
      for (var i in flightClassList) {
        i.isSelected = false;
      }
      flightClassList[index].isSelected = true;
      classSelectedValue.value = flightClassList[index].type ?? '';
      classValue.value = flightClassList[index].text ?? '';
      log('Selected Class Value ${classSelectedValue.value}');
    }
    update();
  }

  genRateItems(int count) {
    childrenAgeList.clear();
    for (var i = 0; i < count; i++) {
      childrenAgeList.add(SelectChildrenAge());
    }
    update();
  }

  updateChildrenAge(int index, String count) {
    childrenAgeList[index].age = int.parse(count);
    log(index.toString());
    log(childrenAgeList[index].age.toString());
    update();
  }

  onTapDoneTravellers() {
    if (childrenAgeList.any((element) => element.age == null)) {
      CustomToast.showToast('Please select age of children');
    } else {
      totalTravellers();
      Get.back();
    }
  }

  totalTravellers() {
    totalTravelers.value =
        '${selectedAdultValue.value + selectedChildrenValue.value}';
    update();
  }

  onTapAdults(int v) {
    selectedAdultValue.value = v;
    update();
  }

  onTapOpenClassBottomSheet() {}

  onTapChildren(int v) {
    selectedChildrenValue.value = v;
    genRateItems(v);
    update();
  }

  clearData() {
    originController.value.clear();
    originAirportLocation.value = '';
    destinationAirportLocation.value = '';
    destinationController.value.clear();
    departureDate.value = '';
    returnDate.value = '';
    childrenAgeList.clear();
    originController.value.clear();
    destinationController.value.clear();
    passengerList.clear();
    sliceList.clear();
  }

  onTapSearch() {
    if (originController.value.text.isEmpty) {
      CustomToast.showToast('Please select origin location');
    } else if (destinationController.value.text.isEmpty) {
      CustomToast.showToast('Please select destination location');
    } else if (departureDate.value.isEmpty) {
      CustomToast.showToast('Please enter departure date');
    } else if (isOneWaySelected.value == false && returnDate.value.isEmpty) {
      CustomToast.showToast('Please enter return date');
    } else if (isOneWaySelected.value == false &&
        DateTime.parse(returnDate.value)
            .isBefore(DateTime.parse(departureDate.value))) {
      CustomToast.showToast(
          'Please ensure the return date is After the Departure date');
    } else if (childrenAgeList.any((element) => element.age == null)) {
      CustomToast.showToast('Please select children age');
    } else if (originController.value.text ==
        destinationController.value.text) {
      CustomToast.showToast('Please select children age');
    } else {
      requestData();
      getAirlinesData();

      // clearData();
      // getAirlinesData();
    }
  }

  getAirlinesData() async {
    isLoading.value = true;
    var data = {
      'data': {
        'slices': sliceList?.value.map((item) => item.toJson()).toList(),
        'passengers':
            passengerList?.value.map((item) => item.toJson()).toList(),
        'cabin_class': classSelectedValue.value,
      },
    };

    var response = await ApiCall.httpPostAPi(
      endPoint: ApiConstant.getAirlines,
      token: DuffelConstantValue.duffelToken,
      data: data,
    );
    log(response.body.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data =
          flightModal.FlightDataModal.fromJson(jsonDecode(response.body));

      if (data.data != null) {
        Get.to(
          () => FlightsScreen(
            isOneWayTrip: isOneWaySelected.value,
            cabinClass: classSelectedValue.value,
            // passengerModalList: passengerList,
            // slicesDataList: sliceList,
            allFlightData: data,
          ),
        )?.then((value) => clearData());
        clearData();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      var data = ErrorModal.fromJson(jsonDecode(response.body));
      CustomToast.showToast(data.errors?[0].message.toString() ?? '');
    }
    update();
  }

  selectDate(BuildContext context, {String? type}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate.value.isNotEmpty && type == 'depart'
          ? DateTime.parse(departureDate.value)
          : returnDate.value.isNotEmpty && type == 'return'
              ? DateTime.parse(returnDate.value)
              : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null) {
      if (type == 'depart') {
        if (returnDate.value.isNotEmpty &&
            picked.isAfter(DateTime.parse(returnDate.value)) &&
            isOneWaySelected.value == false) {
          CustomToast.showToast(
            'Please ensure the Departure date is Before the return date',
          );
        } else {
          departureDate.value = dateFormat(picked);
        }
      }
      if (type == 'return') {
        if (departureDate.value.isNotEmpty &&
            picked.isBefore(DateTime.parse(departureDate.value))) {
          CustomToast.showToast(
            'Please ensure the return date is After the Departure date',
          );
        } else {
          returnDate.value = dateFormat(picked);
        }
      }
    }
    update();
  }

  initialDate() {
    departureDate.value = dateFormat(DateTime.now());
    returnDate.value = dateFormat(DateTime.now().add(const Duration(days: 1)));
  }

  init() {
    totalTravellers();
    genRateItems(selectedChildrenValue.value);
    initialDate();
  }

  onTapOriginSuggestion({
    String? location,
    String? cityName,
    String? name,
    String? cityCode,
  }) {
    originAirportLocation.value = '$cityCode,State: ${cityName ?? name ?? ''}';
    originController.value.text = cityCode ?? '';

    update();
  }

  onTapDestinationSuggestion({
    String? location,
    String? cityName,
    String? name,
    String? cityCode,
  }) {
    destinationAirportLocation.value =
        '$cityCode,State: ${cityName ?? name ?? ''}';
    destinationController.value.text = cityCode ?? '';

    update();
  }

  getPlacesData(String suggestion) async {
    airPortSuggestionList.clear();
    var response = await ApiCall.httpGetAPi(
      token: DuffelConstantValue.duffelToken,
      endPoint: '${ApiConstant.getAirportSuggestion}?name=$suggestion',
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = AirportSuggestionModal.fromJson(jsonDecode(response.body));
      airPortSuggestionList.addAll(data.data ?? []);
      airPortSuggestionList.refresh();
    }

    update();
  }

  requestData() {
    sliceList.clear();
    passengerList.clear();
    log('message1234');
    if (selectedAdultValue.value > 0) {
      for (var i = 0; i < selectedAdultValue.value; i++) {
        passengerList.value.add(PassengerModal(type: 'adult'));
      }
    }
    if (childrenAgeList.isNotEmpty) {
      for (var i = 0; i < childrenAgeList.length; i++) {
        if (childrenAgeList[i].age! <= 12) {
          passengerList.value.add(
            PassengerModal(
              // fareType: 'contract_bulk_infant_without_seat',
              age: childrenAgeList[i].age,
            ),
          );
        }
        // else if (childrenAgeList[i].age! <= 5) {
        //   passengerList.value.add(
        //     PassengerModal(
        //       // fareType: 'contract_bulk_infant_with_seat',
        //       age: childrenAgeList[i].age,
        //     ),
        //   );
        // } else {
        //   passengerList.value.add(
        //     PassengerModal(
        //       // fareType: 'student',
        //       age: childrenAgeList[i].age,
        //     ),
        //   );
        // }
      }
    }

    if (isOneWaySelected.value == true) {
      sliceList.add(
        Slices(
          origin: originController.value.text,
          destination: destinationController.value.text,
          departDate: departureDate.value,
        ),
      );
    } else {
      sliceList.add(
        Slices(
          origin: originController.value.text,
          destination: destinationController.value.text,
          departDate: departureDate.value,
        ),
      );

      sliceList.add(
        Slices(
          origin: destinationController.value.text,
          destination: originController.value.text,
          departDate: returnDate.value,
        ),
      );
    }

    log('Slice list ${sliceList.length}');
  }

  // getAirlinesData() async {
  //   isLoading.value = true;
  //   var data = {
  //     'data': {
  //       'slices': sliceList.value.map((item) => item.toJson()).toList(),
  //       'passengers': passengerList.value.map((item) => item.toJson()).toList(),
  //       'cabin_class': classSelectedValue.value,
  //     },
  //   };
  //
  //   var response = await ApiCall.httpPostAPi(
  //     endPoint: ApiConstant.getAirlines,
  //     token: DuffelConstantValue.duffelToken,
  //     data: data,
  //   );
  //   log(response.toString());
  //   isLoading.value = false;
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data =
  //         flightModal.FlightDataModal.fromJson(jsonDecode(response.body));
  //
  //     Get.to(
  //       () => FlightsScreen(
  //         isOneWayTrip: isOneWaySelected.value,
  //         flightDataModal: data,
  //       ),
  //     );
  //   }
  //   update();
  // }

  @override
  void onInit() {
    super.onInit();
    init();
  }
}
