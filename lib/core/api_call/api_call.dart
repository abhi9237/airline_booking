import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiCall {
  static ApiCall? _instance;
  // Avoid self instance
  ApiCall._();
  static ApiCall get instance {
    _instance ??= ApiCall._();

    return _instance!;
  }

  static Future httpPostAPi({
    endPoint,
    token,
    queryParameters,
    data,
  }) async {
    var headers = token != null
        ? {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Duffel-Version': 'v1',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept': 'application/json',
            // 'Content-Length': '<calculated when request is sent>'
          }
        : {
            'Content-Type': 'application/json',
            'Authorization': '',
            'Duffel-Version': 'v1',
            'Accept-Encoding': 'gzip',
            'Accept': 'application/json',
          };
    // log('\nRequest Body:\n\nendPoint: $endPoint\n\ntoken: $token\n\nqueryParameters: $queryParameters\n\ndata: ${data.fields}\n\nheaders: $headers\n\n\n');

    try {
      log('\nRequest Body:\n\nendPoint: $endPoint\n\ntoken: $token\n\nqueryParameters: $queryParameters\n\ndata: $data\n\nheaders: $headers\n\n\n');
      // dio.interceptors.add(
      //   AwesomeDioInterceptor(
      //     logRequestTimeout: false,
      //     logResponseHeaders: false,
      //   ),
      // );

      log('My Headers ${headers.toString()}');
      var response = await http.post(
        Uri.parse(endPoint),
        headers: headers,
        body: jsonEncode(data),
      );
      log('Response:: ${response.body.toString()}');

      if (response.statusCode == 200 || response.statusCode == 201)
      // if (response.data['status'] == 200)
      {
        log('\nResponse Body:\n\n${const JsonEncoder.withIndent('  ').convert(response.body)}\n\n\n\n');
        log('\n================================================================\n================================================================\nAPI CALL END\n');
        return response;
      } else {
        return response;
      }
    } on Exception catch (e) {
      // handleStatusCodeResponse(e.response);
      // log('ApiCall Post Method <===>> ${e}');
      log('ApiCall Post Method <===>> ${e.toString()}');
      // log("ApiCall Post Method <===>> ${e.response?.data['message']}");
      // Get.defaultDialog(title: "Error", middleText: e.response?.data['message'], backgroundColor: Colors.grey);
      // commonToast(e.response?.data['message'], isError: true);
    }
  }

  static Future httpGetAPi({
    endPoint,
    token,
    queryParameters,
    data,
  }) async {
    var headers = token != null
        ? {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Duffel-Version': 'v1',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept': 'application/json',
            // 'Content-Length': '<calculated when request is sent>'
          }
        : {
            'Content-Type': 'application/json',
            'Authorization': '',
            'Duffel-Version': 'v1',
            'Accept-Encoding': 'gzip',
            'Accept': 'application/json',
          };
    // log('\nRequest Body:\n\nendPoint: $endPoint\n\ntoken: $token\n\nqueryParameters: $queryParameters\n\ndata: ${data.fields}\n\nheaders: $headers\n\n\n');

    try {
      log('\nRequest Body:\n\nendPoint: $endPoint\n\ntoken: $token\n\nqueryParameters: $queryParameters\n\ndata: $data\n\nheaders: $headers\n\n\n');
      // dio.interceptors.add(
      //   AwesomeDioInterceptor(
      //     logRequestTimeout: false,
      //     logResponseHeaders: false,
      //   ),
      // );
      log('My Headers ${headers.toString()}');
      var response = await http.get(
        Uri.parse(endPoint),
        headers: headers,
      );
      log('My Headers ${response.toString()}');

      if (response.statusCode == 200 || response.statusCode == 201)
      // if (response.data['status'] == 200)
      {
        log('\nResponse Body:\n\n${const JsonEncoder.withIndent('  ').convert(response.body)}\n\n\n\n');
        log('\n================================================================\n================================================================\nAPI CALL END\n');
        return response;
      }
    } on Exception catch (e) {
      // handleStatusCodeResponse(e.response);
      // log('ApiCall Post Method <===>> ${e}');
      log('ApiCall Post Method <===>> ${e.toString()}');
      // log("ApiCall Post Method <===>> ${e.response?.data['message']}");
      // Get.defaultDialog(title: "Error", middleText: e.response?.data['message'], backgroundColor: Colors.grey);
      // commonToast(e.response?.data['message'], isError: true);
    }
  }
}
