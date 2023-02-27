import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/booking_model.dart';

class BookingRepository {
  List<BookingModel> bookingList = <BookingModel>[];
  final Dio dio = Client().init();
  Future<ApiResponse<List<BookingModel>>> getAllBookings(
      String bookingStatus) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('/user/order?order_status=$bookingStatus'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        bookingList = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return BookingModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<BookingModel>>.completed(bookingList);
      } else {
        return ApiResponse<List<BookingModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<BookingModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<BookingModel>>.error(e.toString());
    }
  }
}
