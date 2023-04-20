// ignore_for_file: strict_raw_type, always_specify_types

import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetryer {
  DioConnectivityRequestRetryer({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    log('DioConnectivityRequestRetryer scheduleRequestRetry ');

    StreamSubscription? streamSubscription;
    final Completer<Response> responseCompleter = Completer<Response>();
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          log('DioConnectivityRequestRetryer scheduleRequestRetry connectivityResult != ConnectivityResult.none ');

          streamSubscription?.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                extra: requestOptions.extra,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType,
                validateStatus: requestOptions.validateStatus,
                receiveDataWhenStatusError:
                    requestOptions.receiveDataWhenStatusError,
                followRedirects: requestOptions.followRedirects,
                maxRedirects: requestOptions.maxRedirects,
                requestEncoder: requestOptions.requestEncoder,
                responseDecoder: requestOptions.responseDecoder,
                listFormat: requestOptions.listFormat,
                sendTimeout: requestOptions.sendTimeout,
                receiveTimeout: requestOptions.receiveTimeout,
              ),
            ),
          );
        }
      },
    );
    return responseCompleter.future;
  }
}
