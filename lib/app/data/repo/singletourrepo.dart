import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/single_tour_model.dart';

class SingleTourRepository {
  SingleTourModel tourData = SingleTourModel();
  List<SingleTourModel> packageData = <SingleTourModel>[];
  final Dio dio = Client().init();
  Future<ApiResponse<List<SingleTourModel>>> getSingleTour(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages/$id?option=batch'),
          options: Options(headers: authHeader));
      log('bbdfbiadb repo batch msg${res.statusMessage}');
      log('bbdfbiadb repo batch data ${res.data}');
      log("bbdfbiadb repo batch data result${res.data!['result']}");
      log("bbdfbiadb repo batch data result [0] ${res.data!['result'][0]}");
      if (res.statusCode == 200) {
        packageData = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleTourModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<SingleTourModel>>.completed(packageData);
      } else {
        log('bbdfbiadb repo batch else msg${res.statusMessage}');
        return ApiResponse<List<SingleTourModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      log('bbdfbiadb repo batch de err${de.error}');
      log('bbdfbiadb repo batch de err msg${de.message}');
      return ApiResponse<List<SingleTourModel>>.error(de.error.toString());
    } catch (e) {
      log('bbdfbiadb repo batch catch err msg$e');
      return ApiResponse<List<SingleTourModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<SingleTourModel>>> getSingleTourIndividual(
      int id) async {
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
        packageData = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleTourModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('bbdfbiadb batch rep data length${packageData[0].packageData?.length}');
        return ApiResponse<List<SingleTourModel>>.completed(packageData);
      } else {
        log('bbdfbiadb batch rep statusmessage${res.statusMessage}');

        return ApiResponse<List<SingleTourModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      log('bbdfbiadb batch rep de err${de.error}');

      return ApiResponse<List<SingleTourModel>>.error(de.error.toString());
    } catch (e) {
      log('bbdfbiadb batch rep e cathc$e');

      return ApiResponse<List<SingleTourModel>>.error(e.toString());
    }
  }
}
