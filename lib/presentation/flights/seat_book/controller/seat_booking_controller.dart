import 'dart:developer';

import 'package:get/get.dart';

import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../modal/flight_detail_modal.dart' as flightModal;
import '../modal/seat_modal.dart';

class SeatBookingController extends GetxController {
  RxList patternList = ['A', 'B', 'C'].obs;
  String? offerId;
  int? passangerLength;
  final RxList<Rows>? allRowList;
  final RxList<Rows>? allReturnRowList;
  SeatBookingController(
      {this.offerId,
      this.isOneWayTripSelected,
      this.passangerLength = 0,
      required this.seatSelection,
      this.allRowList,
      this.allReturnRowList});
  RxBool isSelectedTripType = false.obs;
  bool? isOneWayTripSelected;
  RxInt seatCount = 0.obs;
  List<SeatSelection> seatSelection = <SeatSelection>[];

  RxList<Data> seatsDataList = <Data>[].obs;

  RxInt seatSelectionCount = 0.obs;
  RxInt returnSeatSelectionCount = 0.obs;

  int oneWaySeatSelection() {
    int count = 0;
    if (seatSelection.isNotEmpty) {
      for (var i in seatSelection) {
        log('Yes one way type ${i.type.toString()}');
        if (i.type == 'oneWay') {
          count = count + 1;
        }
      }
    }
    log('Here is one away count value ${count.toString()}');
    return count;
  }

  int returnSeatSelection() {
    int count = 0;
    if (seatSelection.isNotEmpty) {
      for (var i in seatSelection) {
        log('Yes return type ${i.type.toString()}');
        if (i.type == 'return') {
          count = count + 1;
        }
      }
    }
    log('Here is return count value ${count.toString()}');
    return count;
  }

  @override
  void onInit() {
    super.onInit();
    seatSelectionCount.value = oneWaySeatSelection();
    returnSeatSelectionCount.value = returnSeatSelection();
    if (seatSelection.isEmpty) {
      if (isOneWayTripSelected == false) {
        if (allReturnRowList != null && allReturnRowList!.isNotEmpty) {
          for (var i in allReturnRowList!) {
            if (i.sections != null && i.sections!.isNotEmpty) {
              for (var j in i.sections!) {
                if (j.elements != null && j.elements!.isNotEmpty) {
                  for (var k in j.elements!) {
                    k.isSelected = false;
                  }
                }
              }
            }
          }
        }
      }
      if (allRowList != null && allRowList!.isNotEmpty) {
        for (var i in allRowList!) {
          if (i.sections != null && i.sections!.isNotEmpty) {
            for (var j in i.sections!) {
              if (j.elements != null && j.elements!.isNotEmpty) {
                for (var k in j.elements!) {
                  k.isSelected = false;
                }
              }
            }
          }
        }
      }
    }
  }

  onTapFlightDetails({
    flightModal.Offers? offer,
    String? classType,
    int? index,
  }) {
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
        index ?? 0,
      ),
      arriveTime: convertTime(
        offer?.slices?[index ?? 0].segments?[0].arrivingAt ?? '',
      ),
      carryBagCount: carryOnBagCount(
        offer,
        index ?? 0,
      ),
      checkedBagCount: checkedBagCount(
        offer,
        index ?? 0,
      ),
      departureDate: formattedNullAbleStringDepartDateIndex(
        offer,
        index ?? 0,
      ),
      departureTime: convertTime(
        offer?.slices?[index ?? 0].segments?[0].departingAt ?? '',
      ),
      destinationItaCode:
          offer?.slices?[index ?? 0].destination?.iataCode ?? '',
      destinationLocation:
          '${offer?.slices?[index ?? 0].destination?.cityName ?? ''} (${offer?.slices?[index ?? 0].destination?.iataCityCode ?? ''})',
      duration: offer?.slices?[index ?? 0].segments?[0].duration
              ?.replaceFirst('PT', '')
              .replaceFirst('P1DT', '')
              .replaceFirst('P2DT', '') ??
          '',
      originItaCode: offer?.slices?[index ?? 0].origin?.iataCode ?? '',
      originLocation:
          '${offer?.slices?[index ?? 0].origin?.cityName ?? ''} (${offer?.slices?[index ?? 0].origin?.iataCityCode ?? ''})',
    );
  }

  String carryOnBagCount(flightModal.Offers? offers, int sliceIndex) {
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

  String checkedBagCount(flightModal.Offers? offers, int sliceIndex) {
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

  onTapOneWaySeatSelection(bool value) {
    log('seatSelectionCount ${seatSelectionCount.toString()}');
    if (value == true) {
      value = false;

      seatSelectionCount--;
    } else if (seatSelectionCount.value == passangerLength) {
      CustomToast.showToast(
        'Seats are selected for all passangers',
      );
    } else {
      value = true;

      seatSelectionCount++;
      // onTapSeat != null
      //     ? onTapSeat!(
      //         allRowList[index1 + 1]
      //                 .sections?[index2]
      //                 .elements?[index3] ??
      //             Elements(),
      //       )
      //     : null;
    }
    update();
  }

  onTapReturnSeatSelection(bool value) {}
  String formattedNullAbleStringDepartDateIndex(
    flightModal.Offers? offers,
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
    flightModal.Offers? offers,
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

  int crossAxisCount(RxList<Data> seatsDataList) {
    int count = 2;
    if (seatsDataList.isNotEmpty &&
        seatsDataList[0].cabins != null &&
        seatsDataList[0].cabins!.isNotEmpty) {
      count = seatsDataList[0].cabins![0].aisles! + 1;
    }
    return count;
  }

  onTapDone() {
    if (seatSelection.isEmpty) {
      CustomToast.showToast('Please select seat for booking');
    } else {
      Get.back(result: seatSelection);
    }
  }
}

class SeatBookingModal {
  bool? isBooked;
  String? seatName;
  SeatBookingModal({this.isBooked, this.seatName});
}

class SeatSelection {
  String? price;
  int? quantity;
  String? id;
  String? type;
  SeatSelection({this.quantity, this.id, this.price, this.type});
}
