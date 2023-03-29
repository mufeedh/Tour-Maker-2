import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/order_model.dart';
import '../models/razorpay_model.dart';
import '../models/traveller_model.dart';

class PassengerRepository {
  TravellerModel passengerList = TravellerModel();
  final Dio dio = Client().init();
  Future<ApiResponse<int>> addOrder(OrderModel om) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('user/order'),
          data: om.toJson(),
          options: Options(headers: authHeader));
      log('adeebika data ${res.data!['order_id']}');
      log('adeebika msg ${res.statusMessage}');
      // log('adeebika data[res] ${res.data!['oer']}');

      if (res.statusCode == 200) {
        log('adeeb rep ${res.statusMessage}');

        // var orderId = res.data!['ordr_id'];
        // OrderModel.fromJson(as Map<String, int>);
        // log('adee $orderId');
        return ApiResponse<int>.completed(res.data!['order_id'] as int);
      } else {
        return ApiResponse<int>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<int>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<int>.error(e.toString());
    }
  }

  Future<ApiResponse<OrderPaymentModel>> createPayment(
      OrderPaymentModel orderPaymentModel) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> response = await dio.postUri(
          Uri.parse('createpayment'),
          data: orderPaymentModel.toJson(),
          options: Options(headers: authHeader));
      log('hayavan 1');
      if (response.statusCode == 200) {
        final OrderPaymentModel razorpay = OrderPaymentModel.fromJson(
            response.data!['result'] as Map<String, dynamic>);
        return ApiResponse<OrderPaymentModel>.completed(razorpay);
      } else {
        log('hayavan 1 res msg${response.statusMessage}');
        return ApiResponse<OrderPaymentModel>.error(response.statusMessage);
      }
    } on DioError catch (de) {
      log('hayavan 1 de err${de.error}');
      return ApiResponse<OrderPaymentModel>.error(de.error.toString());
    } catch (e) {
      log('hayavan 1 catch $e');
      return ApiResponse<OrderPaymentModel>.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> verifyPayment(
    String? mpaymentID,
    String? msignature,
    String? orderID,
  ) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> response = await dio.postUri(
          Uri.parse('verifypayment'),
          options: Options(headers: authHeader),
          data: <String, dynamic>{
            'order_id': orderID,
            'merchant_payment_id': mpaymentID,
            'merchant_signature': msignature
          });
      if (response.statusCode == 200) {
        log('adeeb raz${response.statusMessage}');
        log('adeeb ${response.data!['success']}');

        // log('adeeb ${response.da}');
        final bool razorpay = response.data!['success'] as bool;
        log('adeeb messsage $razorpay');
        return ApiResponse<bool>.completed(razorpay);
      } else {
        return ApiResponse<bool>.error(response.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<bool>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }

  Future<ApiResponse<bool>> addpassenger(
    String? mpaymentID,
    String? msignature,
    String? orderID,
  ) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> response = await dio.postUri(
          Uri.parse('verifypayment'),
          options: Options(headers: authHeader),
          data: <String, dynamic>{
            'order_id': orderID,
            'merchant_payment_id': mpaymentID,
            'merchant_signature': msignature
          });
      if (response.statusCode == 200) {
        log('adeeb raz${response.statusMessage}');
        log('adeeb ${response.data!['success']}');

        // log('adeeb ${response.da}');
        final bool razorpay = response.data!['success'] as bool;
        log('adeeb messsage $razorpay');
        return ApiResponse<bool>.completed(razorpay);
      } else {
        return ApiResponse<bool>.error(response.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<bool>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<bool>.error(e.toString());
    }
  }
}
