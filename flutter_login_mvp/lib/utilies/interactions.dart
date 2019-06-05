
import 'package:flutter_login_mvp/ui/login/model/response_data_api.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'dart:convert';
import 'dart:async';
import 'constains.dart';
import 'errorr_message.dart';
class ApiConnection {
  Future<ApiResponseData>getData(String url) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var response = ApiResponseData();
      response.errorCode = 1;
      response.message = noConnectionError;
      return response;
    }
    final response = await http.get(url).timeout(new Duration(seconds: 30));
    if (response.statusCode == 200) {
      return ApiResponseData.fromJson(json.decode(response.body));
    } else {
      var response = ApiResponseData();
      response.message = errorCodeData;
      response.errorCode = 1;
      return response;
    }
  }
  Future<ApiResponseData> createPost(String url, {Map body}) async {
    return http.post(API_URL + url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return ApiResponseData.fromJson(json.decode(response.body));
    });
  }

}

