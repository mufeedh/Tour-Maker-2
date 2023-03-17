import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/package_model.dart';
import '../models/travveltypes_model.dart';

class TravelTypesRepository {
  List<PackageModel> travelTypesToursList = <PackageModel>[];
  List<TravelTypesModel> travelTypesToursLis = <TravelTypesModel>[];

  final Dio dio = Client().init();

  Future<ApiResponse<List<TravelTypesModel>>> getAllTravelTypesTours() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/traveltypes'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        travelTypesToursLis =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return TravelTypesModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<TravelTypesModel>>.completed(
            travelTypesToursLis);
      } else {
        return ApiResponse<List<TravelTypesModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<TravelTypesModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<TravelTypesModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<PackageModel>>> getSingleTravelTypesTours(
      String name) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/traveltypes?destination=$name'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        travelTypesToursList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return PackageModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<PackageModel>>.completed(travelTypesToursList);
      } else {
        return ApiResponse<List<PackageModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<PackageModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<PackageModel>>.error(e.toString());
    }
  }
}
