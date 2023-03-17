import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/package_model.dart';
import '../models/trending_tours.dart';

class TrendingToursRepository {
  List<TrendingToursModel> trndingToursList = <TrendingToursModel>[];
  List<PackageModel> packageToursList = <PackageModel>[];
  final Dio dio = Client().init();

  Future<ApiResponse<List<TrendingToursModel>>> getAllTrendingTours() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/trending'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        trndingToursList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return TrendingToursModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<TrendingToursModel>>.completed(
            trndingToursList);
      } else {
        return ApiResponse<List<TrendingToursModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<TrendingToursModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<TrendingToursModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<PackageModel>>> getSingleTrendingTours(
      String name) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/trending?destination=$name'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        packageToursList =
            (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return PackageModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<PackageModel>>.completed(packageToursList);
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
