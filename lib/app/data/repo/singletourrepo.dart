import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/single_tour_model.dart';

class SingleTourRepository {
  SingleTourModel tourData = SingleTourModel();
  List<SingleTourModel> packageData = <SingleTourModel>[];
  final Dio dio = Client().init();
  Future<ApiResponse<SingleTourModel>> getSingleTour(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages/$id?option=batch'),
          options: Options(headers: authHeader));
      log('bbdfbiadb repo batch msg${res.statusMessage}');
      log('bbdfbiadb repo batch data ${res.data}');
      log("bbdfbiadb repo batch data result${res.data!['result']}");
      log("bbdfbiadb repo batch data result [0] ${res.data!['result']}");
      if (res.statusCode == 200) {
        tourData = SingleTourModel.fromJson(
            res.data!['result'] as Map<String, dynamic>);

        return ApiResponse<SingleTourModel>.completed(tourData);
      } else {
        log('bbdfbiadb repo batch else msg${res.statusMessage}');
        return ApiResponse<SingleTourModel>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      log('bbdfbiadb repo batch de err${de.error}');
      log('bbdfbiadb repo batch de err msg${de.message}');
      return ApiResponse<SingleTourModel>.error(de.error.toString());
    } catch (e) {
      log('bbdfbiadb repo batch catch err msg$e');
      return ApiResponse<SingleTourModel>.error(e.toString());
    }
  }

  Future<ApiResponse<SingleTourModel>> getSingleTourIndividual(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages/$id?option=individual'),
          options: Options(headers: authHeader));
      log('bbdfbiadb batch data  ${res.data}');
      log('bbdfbiadb batch data[res]  ${res.data!['result']}');
      log('bbdfbiadb batch msg ${res.statusMessage}');
      if (res.statusCode == 200) {
        log('bbdfbiadb batch rep msg${res.statusMessage}');
        tourData = SingleTourModel.fromJson(
            res.data!['result'] as Map<String, dynamic>);

        // log('bbdfbiadb batch rep data length${packageDat.packageData?.length}');
        return ApiResponse<SingleTourModel>.completed(tourData);
      } else {
        log('bbdfbiadb batch rep statusmessage${res.statusMessage}');

        return ApiResponse<SingleTourModel>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      log('bbdfbiadb batch rep de err${de.error}');

      return ApiResponse<SingleTourModel>.error(de.error.toString());
    } catch (e) {
      log('bbdfbiadb batch rep e cathc$e');

      return ApiResponse<SingleTourModel>.error(e.toString());
    }
  }
}
