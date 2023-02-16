import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/category_model.dart';

class CategoryRepository {
  List<CategoryModel> categoryList = <CategoryModel>[];
  final Dio dio = Client().init();
  Future<ApiResponse<List<CategoryModel>>> getAllCategory() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('tours/categories'),
          options: Options(headers: authHeader));

      if (res.statusCode == 200) {
        categoryList = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return CategoryModel.fromJson(e as Map<String, String>);
        }).toList();
        return ApiResponse<List<CategoryModel>>.completed(categoryList);
      } else {
        return ApiResponse<List<CategoryModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<CategoryModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<CategoryModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<CategoryModel>>> getCategorybycategoryName(
      String categoryname) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> response = await dio.getUri(
          Uri.parse('tours/packages?category=$categoryname'),
          options: Options(headers: authHeader));
      if (response.statusCode == 200) {
        categoryList =
            (response.data!['result'] as List<dynamic>).map((dynamic e) {
          return CategoryModel.fromJson(e as Map<String, String>);
        }).toList();
        return ApiResponse<List<CategoryModel>>.completed(categoryList);
      } else {
        return ApiResponse<List<CategoryModel>>.error(response.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<CategoryModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<CategoryModel>>.error(e.toString());
    }
  }
}