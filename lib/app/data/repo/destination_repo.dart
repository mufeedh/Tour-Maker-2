import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/destinations_model.dart';
import '../models/package_model.dart';

class DestinationRepository {
  final Dio dio = Client().init();
  List<PackageModel> destinationsLis = <PackageModel>[];
  List<DestinationsModel> destinationsList = <DestinationsModel>[];

  Future<ApiResponse<List<DestinationsModel>>> getAllDestinations() async {
    try {
      final Map<String, dynamic>? authorHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio
          .get('tours/destination', options: Options(headers: authorHeader));
      log('try');
      if (res.statusCode == 200) {
        destinationsList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return DestinationsModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<DestinationsModel>>.completed(destinationsList);
      } else {
        return ApiResponse<List<DestinationsModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<DestinationsModel>>.error(de.error as String);
    } catch (e) {
      return ApiResponse<List<DestinationsModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<PackageModel>>> getDestination(
      String destination) async {
    try {
      final Map<String, dynamic>? authorHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.get(
          'tours/packages?destination=$destination',
          options: Options(headers: authorHeader));

      if (res.statusCode == 200) {
        log('200');
        destinationsLis =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return PackageModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('list ${destinationsLis.length}');
        return ApiResponse<List<PackageModel>>.completed(destinationsLis);
      } else {
        return ApiResponse<List<PackageModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<PackageModel>>.error(de.error as String);
    } catch (e) {
      return ApiResponse<List<PackageModel>>.error(e.toString());
    }
  }
}
