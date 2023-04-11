import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  GetStorage storage = GetStorage();
  Dio init(
      {String baseUrl =
          'https://uuuhc8u0vk.execute-api.ap-south-1.amazonaws.com/development_api/'}) {
    final Dio dio = Dio();

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
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
    final dynamic tok = await storage.read('token');
    // var t=  storage.;
    log('token in client $tok');

    if (tok != null) {
      log('tokenn != null');

      final Map<String, dynamic> header = <String, dynamic>{
        // "X-Requested-With": "XMLHttpRequest",
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $tok',
      };
      log('header $header');

      return header;
    } else {
      return null;
    }
  }

  Future<Map<String, String>?> getMultiPartAuthHeader() async {
    final dynamic tok = await storage.read('token');
    // var t=  storage.;
    log('token in client $tok');

    if (tok != null) {
      log('tokenn != null');

      final Map<String, String> header = <String, String>{
        // "X-Requested-With": "XMLHttpRequest",
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $tok',
      };
      log('header $header');

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
