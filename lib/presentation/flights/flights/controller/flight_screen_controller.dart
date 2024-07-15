import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../modal/flight_detail_modal.dart';
import '../../search_flight/modal/search_flight_modal.dart' as searchModal;

class FlightScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<searchModal.Slices>? slicesDataList = <searchModal.Slices>[].obs;
  RxList<searchModal.PassengerModal>? passengerModalList =
      <searchModal.PassengerModal>[].obs;
  String? cabinClass;
  FlightDataModal allFlightData = FlightDataModal();
  RxList<Timer> timers = <Timer>[].obs;
  Duration remainingTime = const Duration();
  DateTime expiresAt = DateTime.now();
  DateTime offerUpdatedAt = DateTime.now();
  RxString formattedTime = ''.obs;
  List<ValueNotifier<String>> formattedTimes = [];

  FlightScreenController({
    this.passengerModalList,
    this.slicesDataList,
    this.cabinClass,
    required this.allFlightData,
  });

  @override
  void onClose() {
    super.onClose();
    for (var i in timers) {
      i.cancel();
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getAirlinesData();
    if (allFlightData.data?.offers != null &&
        allFlightData.data!.offers!.isNotEmpty) {
      startTimers(allFlightData.data?.offers ?? []);
    }
    getAirlineStops();
  }

  String getAirlineStops() {
    List<String> stopsList = [];
    if (allFlightData.data != null &&
        allFlightData.data!.slices != null &&
        allFlightData.data!.slices!.isNotEmpty &&
        allFlightData.data!.slices![0].segments != null &&
        allFlightData.data!.slices![0].segments!.isNotEmpty &&
        allFlightData.data!.slices![0].segments![0].stops != null &&
        allFlightData.data!.slices![0].segments![0].stops!.isNotEmpty) {
      for (var i = 0;
          i < allFlightData.data!.slices![0].segments![0].stops!.length;
          i++) {
        var data =
            '${allFlightData.data!.slices![0].segments![0].stops?[i].airport?.name ?? ''},${allFlightData.data!.slices![0].segments![0].stops?[i].airport?.cityName ?? ''}';
        stopsList.add(data);
      }
    }
    return stopsList.join(',');
  }

  String formattedNullableDateString(Data? data) {
    if (data != null &&
        data.offers != null &&
        data.offers!.isNotEmpty &&
        data.offers?[0].slices != null &&
        data.offers![0].slices!.isNotEmpty &&
        data.offers?[0].slices?[0].segments != null &&
        data.offers![0].slices![0].segments!.isNotEmpty &&
        data.offers?[0].slices?[0].segments?[0].departingAt != null) {
      return dateFormatString(
        data.offers?[0].slices?[0].segments?[0].departingAt ?? '',
      );
    }
    return '';
  }

  String formattedNullAbleStringDepartDateIndex(
    Data? data,
    int index,
    int sliceIndex,
  ) {
    if (data != null &&
        data.offers != null &&
        data.offers!.isNotEmpty &&
        data.offers?[index].slices != null &&
        data.offers![index].slices!.isNotEmpty &&
        data.offers?[index].slices?[sliceIndex].segments != null &&
        data.offers![index].slices![sliceIndex].segments!.isNotEmpty &&
        data.offers?[index].slices?[sliceIndex].segments?[0].departingAt !=
            null) {
      return dateFormatString(
        data.offers?[index].slices?[sliceIndex].segments?[0].departingAt ?? '',
      );
    }
    return '';
  }

  String formattedNullAbleStringArriveDateIndex(
    Data? data,
    int index,
    int sliceIndex,
  ) {
    if (data != null &&
        data.offers != null &&
        data.offers!.isNotEmpty &&
        data.offers?[index].slices != null &&
        data.offers![index].slices!.isNotEmpty &&
        data.offers?[index].slices?[sliceIndex].segments != null &&
        data.offers![index].slices![sliceIndex].segments!.isNotEmpty &&
        data.offers?[index].slices?[sliceIndex].segments?[0].departingAt !=
            null) {
      return dateFormatString(
        data.offers?[index].slices?[sliceIndex].segments?[0].arrivingAt ?? '',
      );
    }
    return '';
  }

  String carryOnBagCount(Data? data, int index) {
    // controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
    //     .segments?[0].passengers[0].baggages[0].quantity.toString()

    if (data != null &&
        data.offers != null &&
        data.offers!.isNotEmpty &&
        data.offers![index].slices != null &&
        data.offers![index].slices!.isNotEmpty &&
        data.offers![index].slices![0].segments != null &&
        data.offers![index].slices![0].segments!.isNotEmpty &&
        data.offers?[index].slices?[0].segments?[0].passengers != null &&
        data.offers![index].slices![0].segments![0].passengers!.isNotEmpty &&
        data.offers?[index].slices?[0].segments?[0].passengers![0].baggages !=
            null &&
        data.offers![index].slices![0].segments![0].passengers![0].baggages!
            .isNotEmpty) {
      return data.offers?[index].slices?[0].segments?[0].passengers?[0]
              .baggages?[1].quantity
              .toString() ??
          '';
    }
    return '';
  }

  String checkedBagCount(Data? data, int index) {
    // controller?.allFlightData.data?.offers?[index ?? 0].slices?[0]
    //     .segments?[0].passengers[0].baggages[0].quantity.toString()

    if (data != null &&
        data.offers != null &&
        data.offers!.isNotEmpty &&
        data.offers![index].slices != null &&
        data.offers![index].slices!.isNotEmpty &&
        data.offers![index].slices![0].segments != null &&
        data.offers![index].slices![0].segments!.isNotEmpty &&
        data.offers?[index].slices?[0].segments?[0].passengers != null &&
        data.offers![index].slices![0].segments![0].passengers!.isNotEmpty &&
        data.offers?[index].slices?[0].segments?[0].passengers![0].baggages !=
            null &&
        data.offers![index].slices![0].segments![0].passengers![0].baggages!
            .isNotEmpty) {
      return data.offers?[index].slices?[0].segments?[0].passengers?[0]
              .baggages?[0].quantity
              .toString() ??
          '';
    }
    return '';
  }

  String flightOriginToDestinationLocation() {
    return '${allFlightData.data?.offers?[0].slices?[0].origin?.cityName ?? ''} (${allFlightData.data?.offers?[0].slices?[0].origin?.iataCode ?? ''}) to ${allFlightData.data?.offers?[0].slices?[0].destination?.cityName ?? ''} (${allFlightData.data?.offers?[0].slices?[0].destination?.iataCode ?? ''})';
  }

  String adultChildCount() {
    int adultCount = 0;
    int childCount = 0;

    if (allFlightData.data != null &&
        allFlightData.data!.passengers != null &&
        allFlightData.data!.passengers!.isNotEmpty) {
      for (var i in allFlightData.data!.passengers!) {
        if (i.type == 'adult') {
          adultCount++;
        } else {
          childCount++;
        }
      }
    }
    return '${adultCount > 0 ? '$adultCount Adult' : ''}, ${childCount > 0 ? '$childCount child' : ''}';
  }

  // String offerExpires(String? offerCreated, String? expireAt) {
  //
  //   expiresAt = DateTime.parse(expireAt ?? '');
  //   offerUpdatedAt = DateTime.parse(offerCreated ?? '');
  //   startCountdownTimer();
  //
  //   return formattedTime.value ?? '';
  // }

  void startCountdownTimer(
      // String? offerCreated, String? expireAt
      ) {
    Timer countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime = expiresAt.difference(DateTime.now());

      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
        formattedTime.value = '00:00:00';
        print('Timer finished!');
      } else {
        formattedTime.value = formatDuration(remainingTime);
      }
    });
    // DateTime dateTime1 = DateTime.parse(offerCreated ?? '');
    // DateTime dateTime2 = DateTime.parse(expireAt ?? '');
    // remainingTime = dateTime2.difference(dateTime1);
    // if (remainingTime.inSeconds <= 0) {
    //   for (var i in timers) {
    //     i.cancel();
    //   }
    //   formattedTime.value = '00:00:00';
    //   print('Timer finished!');
    // } else {
    //   remainingTime -= const Duration(seconds: 1);
    //   formattedTime.value = formatDuration(remainingTime);
    //   // update();
    // }
    // });

    timers.add(countdownTimer);
  }

  void startTimers(List<Offers> datePairs) {
    formattedTimes.clear();
    timers.clear();
    for (var i in datePairs) {
      log('Expiary date ${i.expiresAt.toString()}');
      log('Now date ${DateTime.now().toString()}');
      DateTime expiryDate = DateTime.parse(i.expiresAt ?? '').toLocal();
      Duration remainingTime = expiryDate.difference(DateTime.now());

      Timer countdownTimer =
          Timer.periodic(const Duration(seconds: 1), (timer) {
        remainingTime = expiryDate.difference(DateTime.now());
        // log('Remaining Time${remainingTime.toString()}');
        if (remainingTime.inSeconds <= 0) {
          timer.cancel();
          formattedTimes[datePairs.indexOf(i)].value = '00:00';
          log('Timer finished for pair ${datePairs.indexOf(i)}!');
        } else {
          formattedTimes[datePairs.indexOf(i)].value =
              formatDuration(remainingTime);
        }
      });

      timers.add(countdownTimer);
      formattedTimes.add(ValueNotifier<String>(''));
    }
  }

  String formatDuration(Duration duration) {
    return "${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  // }

  DateTime convertUtcToIst(String dateTimeString) {
    // Parse the date-time string to a DateTime object in UTC
    DateTime utcDateTime = DateTime.parse(dateTimeString);

    // Define the IST offset (UTC+5:30)
    Duration istOffset = const Duration(hours: 5, minutes: 30);

    // Convert the UTC DateTime to IST by adding the offset
    DateTime istDateTime = utcDateTime.add(istOffset);
    log("UTC Time: $utcDateTime");
    log("IST Time: $istDateTime");
    return istDateTime;
  }
}
