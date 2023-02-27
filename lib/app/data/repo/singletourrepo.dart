import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/single_tour_model.dart';

class SingleTourRepository {
  SingleTourModel categoryList = SingleTourModel();
  final Dio dio = Client().init();
  Future<ApiResponse<SingleTourModel>> getSingleTour(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages?id=$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        log('adeeb rep ${res.statusMessage}');
        categoryList = SingleTourModel.fromJson(
            res.data!['result'] as Map<String, dynamic>);
        return ApiResponse<SingleTourModel>.completed(categoryList);
      } else {
        return ApiResponse<SingleTourModel>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<SingleTourModel>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<SingleTourModel>.error(e.toString());
    }
  }
}
