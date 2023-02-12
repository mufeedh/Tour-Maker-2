import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  Dio init(
      {String baseUrl =
          'https://etnh73oqgjtljkgfrqy5ojcysi0tgmza.lambda-url.ap-south-1.on.aws/'}) {
    final Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      maxWidth: 180,
    ));

    dio.options = BaseOptions(
        followRedirects: true,
        baseUrl: baseUrl,
        validateStatus: (int? status) {
          log('inside dio client');
          if (status != null) {
            return status < 500;
          } else {
            return false;
          }
        },
        contentType: 'application/json',
        headers: <String, dynamic>{
          // "X-Requested-With": "XMLHttpRequest",
          // HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.authorizationHeader: "Bearer ${getToken()}"
        });

    return dio;
  }

  Future<Map<String, dynamic>?> getAuthHeader() async {
    if (tok != null) {
      final Map<String, dynamic> header = <String, dynamic>{
        // "X-Requested-With": "XMLHttpRequest",
        // HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $tok',
      };
      return header;
    } else {
      return null;
    }
  }
}

class ApiResponse<T> {
  ApiResponse.error(this.message) : status = ApiResponseStatus.error;
  ApiResponse.unProcessable(this.message)
      : status = ApiResponseStatus.unProcessable;
  ApiResponse.completed(this.data) : status = ApiResponseStatus.completed;
  ApiResponse.loading(this.message) : status = ApiResponseStatus.loading;
  ApiResponse.idle() : status = ApiResponseStatus.idle;
  ApiResponseStatus status;
  T? data;
  String? message;
  @override
  String toString() {
    return 'ApiResponseStatus : $status \n Message : $message \n Data : $data';
  }
}

enum ApiResponseStatus { idle, loading, completed, unProcessable, error }

String tok =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6ImQwNWI0MDljNmYyMmM0MDNlMWY5MWY5ODY3YWM0OTJhOTA2MTk1NTgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdG91ci1tYWtlci0zMWI2NyIsImF1ZCI6InRvdXItbWFrZXItMzFiNjciLCJhdXRoX3RpbWUiOjE2NzU0NDY3NzgsInVzZXJfaWQiOiJrRVI0TFduZE01VnhHZzU5VWo5eUg3UjIyOHoyIiwic3ViIjoia0VSNExXbmRNNVZ4R2c1OVVqOXlIN1IyMjh6MiIsImlhdCI6MTY3NTQ0Njc4MCwiZXhwIjoxNjc1NDUwMzgwLCJlbWFpbCI6InRlc3R1c2VyQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0dXNlckBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.JDDpTvPT1bRwM7lfGfyWyYQtzwpqLCyaGo-5A5meTRzDjoWV1jiIBf17Evtj1KhvrPfs9qt1zCsVvy2vBRnyUk0RMmrYaCsQHtrIqATLML47qxzFMj1KM1hHQGqWygL6mHLbZPDpzBWWH8CMchy4aPMc380J3NYCPw5xOtXByW5XVkIWFKlCUwuDOZPchtrYzPNEYPUaONIKadreWbzUHptTvozoYZ0435UbOh8BCf4gVRfnRqGuKCk7JxSNabnRW0RrWGp9-UuDukPIOMQHs-dYn2llfGm0Szk3arVxMzZcuohxJJj9GOP-dLd9nR76LfIRriwDuz4OP5Fwm_sUzw';
