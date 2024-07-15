import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../../core/api_call/api_call.dart';
import '../../../../core/api_constant/api_contants.dart';
import '../../../../core/common_widgets/common_widgets.dart';
import '../../../../core/common_widgets/custom_toast.dart';
import '../../modal/error_modal.dart';
import '../../modal/flight_detail_modal.dart';
import '../../passenger_contact_detail/modal/passanger_contact_detail_modal.dart';
import '../../seat_book/controller/seat_booking_controller.dart';
import '../../seat_book/modal/seat_modal.dart' as seatModal;
import '../modal/booking_detail_modal.dart';

class BookingDetailsController extends GetxController {
  RxInt childCount = 0.obs;
  RxInt adultCount = 0.obs;
  RxBool isLoadingBooking = false.obs;
  RxList<seatModal.Data> seatsDataList = <seatModal.Data>[].obs;
  RxList<seatModal.Rows> allRowList = <seatModal.Rows>[].obs;
  RxList<seatModal.Rows> allReturnRowList = <seatModal.Rows>[].obs;
  RxList<SeatSelection> seatSelection = <SeatSelection>[].obs;
  RxList<Payments> paymentsList = <Payments>[].obs;
  bool? isOneWayTripSelected;
  RxString totalBookingAmount = ''.obs;
  String? offerId;
  BookingDetailsController({this.offerId, this.isOneWayTripSelected});
  String formattedNullAbleStringDepartDateIndex(
    Offers? offers,
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

  createAirlineOffer({
    List<String>? selectedOffers,
    List<ServicesModal>? servicesList,
    List<PassengerModal>? selectedPassengerList,
  }) async {
    isLoadingBooking.value = true;
    try {
      var data = servicesList != null && servicesList!.isNotEmpty
          ? {
              'data': {
                'services': servicesList?.map((e) => e.toJson()).toList(),
                'selected_offers': selectedOffers,
                'payments': paymentsList.value?.map((e) => e.toJson()).toList(),
                'passengers': selectedPassengerList
                    ?.map((item) => item.toJson())
                    .toList(),
              },
            }
          : {
              'data': {
                'selected_offers': selectedOffers,
                'payments': paymentsList.value?.map((e) => e.toJson()).toList(),
                'passengers': selectedPassengerList
                    ?.map((item) => item.toJson())
                    .toList(),
              },
            };
      log(data.toString());
      var response = await ApiCall.httpPostAPi(
        data: data,
        endPoint: ApiConstant.createOrders,
        token: DuffelConstantValue.duffelToken,
      );
      isLoadingBooking.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Congratulations');

        Get.back();
        Get.back();
        Get.back();
        CustomToast.showToast('Booking Confirmed');
        // var data = BookingDetailModal.fromJson(jsonDecode(response.body));
      } else {
        log('fff');
        var data = ErrorModal.fromJson(jsonDecode(response.body));
        CustomToast.showToast(data.errors?[0].title.toString() ?? '');
      }
    } on Exception catch (e) {
      log('fff');
      // var data = ErrorModal.fromJson(jsonDecode(response.body));
      // CustomToast.showToast(data.errors?[0].message.toString() ?? '');
    }
  }

  getSeatsData() async {
    allRowList.clear();
    var response = await ApiCall.httpGetAPi(
      endPoint: '${ApiConstant.getSeatsData}offer_id=$offerId',
      token: DuffelConstantValue.duffelToken,
    );

    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = seatModal.AirLineSeatModal.fromJson(
        jsonDecode(response.body.toString()),
      );
      log('Data%% ${data.data!.length}');
      seatsDataList.value = data.data ?? [];
      log('  seatsDataList.value  ${seatsDataList.value.length}');
      if (isOneWayTripSelected == false) {
        if (seatsDataList.value.isNotEmpty) {
          for (var i = 0; i < seatsDataList.length; i++) {
            if (i == 1) {
              if (seatsDataList[i].cabins != null &&
                  seatsDataList[i].cabins!.isNotEmpty) {
                for (var j in seatsDataList[i].cabins!) {
                  allReturnRowList.value.addAll(j.rows ?? []);
                  log('Id1====> ${allReturnRowList[0].sections![0].id.toString()}');
                }
              }
            }
          }
          log('allRowList.valueLength1 ${allReturnRowList.value.length.toString()}');
        }
      }
      if (seatsDataList.value.isNotEmpty) {
        for (var i = 0; i < seatsDataList.length; i++) {
          if (i == 0) {
            if (seatsDataList[i].cabins != null &&
                seatsDataList[i].cabins!.isNotEmpty) {
              for (var j in seatsDataList[i].cabins!) {
                allRowList.value = j.rows ?? [];
                log('Id2====> ${allRowList[0].sections![0].id.toString()}');
              }
            }
          }
        }
        log('allRowList.valueLength2 ${allRowList.value.length.toString()}');
      }

      // oneWaySectionData();

      // log(seatsDataList[0].id.toString());
    }
    update();
  }

  String totalAmount({
    String? totalAmount,
    List<SeatSelection>? seatSelection,
  }) {
    double seatAmount = 0.0;
    double seatTotalAmount = 0.0;
    if (seatSelection != null && seatSelection.isNotEmpty) {
      for (var i = 0; i < seatSelection.length; i++) {
        seatAmount = double.parse(seatSelection[i].price ?? '0.0');
        seatTotalAmount = seatTotalAmount + seatAmount;
      }
      double total = double.parse(totalAmount ?? '0.0') + seatTotalAmount;
      totalBookingAmount.value = total.toString();
      return '\$${total.toStringAsFixed(2)}';
    } else {
      totalBookingAmount.value = totalAmount ?? '';
      return '\$$totalAmount' ?? '';
    }
  }

  String seatTotalAmount({
    List<SeatSelection>? seatSelection,
  }) {
    double seatAmount = 0.0;
    double seatTotalAmount = 0.0;
    if (seatSelection != null && seatSelection.isNotEmpty) {
      for (var i = 0; i < seatSelection.length; i++) {
        seatAmount = double.parse(seatSelection[i].price ?? '0.0');
        seatTotalAmount = seatTotalAmount + seatAmount;
      }
      return '\$${seatTotalAmount.toStringAsFixed(2)}';
    } else {
      return '\$';
    }
  }

  onTapBookNow({
    Offers? offers,
    List<String>? selectedOffers,
    List<Payments>? payments,
    List<PassengerModal>? selectedPassengerList,
  }) {
    paymentsList.clear();
    List<ServicesModal> servicesList = [];
    if (seatSelection.value.isNotEmpty) {
      for (var i in seatSelection.value) {
        servicesList.add(ServicesModal(id: i.id, quantity: i.quantity));
      }
    }

    paymentsList.add(
      Payments(
        type: 'balance',
        currency: offers?.baseCurrency ?? '',
        amount: double.parse(totalBookingAmount.value).toStringAsFixed(2),
      ),
    );
    log(seatSelection.value.length.toString());
    createAirlineOffer(
      selectedOffers: selectedOffers,
      selectedPassengerList: selectedPassengerList,
      servicesList: servicesList,
    );
  }

  onTapFlightDetails({
    Offers? offer,
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
              ?.replaceFirst('PT', '') ??
          '',
      originItaCode: offer?.slices?[index ?? 0].origin?.iataCode ?? '',
      originLocation:
          '${offer?.slices?[index ?? 0].origin?.cityName ?? ''} (${offer?.slices?[index ?? 0].origin?.iataCityCode ?? ''})',
    );
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSeatsData();
  }
}
