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
          Uri.parse('tours/packages/$id?option=individual'),
          options: Options(headers: authHeader));
      log('adeebika data ${res.data}');
      log('adeebika data[res] single${res.data!['result']}');
      log('adeebika msg ${res.statusMessage}');
      if (res.statusCode == 200) {
        log('adeeb rep ${res.statusMessage}');
        packageData = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleTourModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('afeeb ${tourData.packageData?.length}');
        return ApiResponse<List<SingleTourModel>>.completed(packageData);
      } else {
        return ApiResponse<List<SingleTourModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<SingleTourModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleTourModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<SingleTourModel>>> getSingleTourBATCH(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages/$id?option=batch'),
          options: Options(headers: authHeader));
      log('adeebika batch data  ${res.data}');
      log('adeebika batch data[res]  ${res.data!['result']}');
      log('adeebika batch msg ${res.statusMessage}');
      if (res.statusCode == 200) {
        log('adeeb rep ${res.statusMessage}');
        packageData = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleTourModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('afeeb ${tourData.packageData?.length}');
        return ApiResponse<List<SingleTourModel>>.completed(packageData);
      } else {
        return ApiResponse<List<SingleTourModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<SingleTourModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleTourModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<SingleTourModel>>> getSingleTourINDIVIDUAL(
      int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/packages/$id?option=individual'),
          options: Options(headers: authHeader));
      log('adeebika data ${res.data}');
      log('adeebika data[res] indivi ${res.data!['result']}');
      log('adeebika msg ${res.statusMessage}');
      if (res.statusCode == 200) {
        log('adeeb rep ${res.statusMessage}');
        packageData = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return SingleTourModel.fromJson(e as Map<String, dynamic>);
        }).toList();

        log('afeeb ${tourData.packageData?.length}');
        return ApiResponse<List<SingleTourModel>>.completed(packageData);
      } else {
        return ApiResponse<List<SingleTourModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<SingleTourModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<SingleTourModel>>.error(e.toString());
    }
  }
}
