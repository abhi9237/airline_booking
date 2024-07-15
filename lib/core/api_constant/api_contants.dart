class ApiConstant {
  static ApiConstant? _instance;
  // Avoid self instance
  ApiConstant._();
  static ApiConstant get instance {
    _instance ??= ApiConstant._();
    return _instance!;
  }

  // Duffel Api Url
  static const baseUrlForDuffel = 'https://api.duffel.com/';

  // Duffel Api End Points

  static const getHotels = '${baseUrlForDuffel}stays/search';
  static const hotelDetails = '${baseUrlForDuffel}stays/search_results/';
  static const hotelAmenities = '${baseUrlForDuffel}stays/accommodation/';
  static const bookingQuotation = '${baseUrlForDuffel}stays/quotes';
  static const roomBooking = '${baseUrlForDuffel}stays/bookings';

  // Flight Booking Api End Points

  static const getAirportSuggestion = '${baseUrlForDuffel}places/suggestions';
  static const getAirlines = '${baseUrlForDuffel}air/offer_requests';
  static const createOrders = '${baseUrlForDuffel}air/orders';
  static const getSeatsData = '${baseUrlForDuffel}air/seat_maps/?';
}

class DuffelConstantValue {
  static const duffelToken =
      'duffel_test_3v8g9QFn17Fq8XYnLLFbfgthulOMs41YdTfbIhKtxUQ';
  static const getHotelLat = 30.7333;
  static const getHotelLong = 76.7794;
  static const hotelCheckInDate = '2024-07-01';
  static const hotelCheckOutDate = '2024-07-02';
  static const isShowHotelButton = true;
  static const isShowFlightButton = true;
}
