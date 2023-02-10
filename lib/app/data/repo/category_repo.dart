import 'package:dio/dio.dart';
import 'package:tour_maker/app/data/models/category_model.dart';
import 'package:tour_maker/app/services/network_services/dio_client.dart';

class CategoryRepository {
  List<CategoryModel> categoryList = [];
  final Dio dio = Client().init();
  Future<ApiResponse<List<CategoryModel>>> getAllCategory() async {
    try {
      var authHeader = await Client().getAuthHeader();
      var res = await dio.getUri(Uri.parse('tours/categories'),
          options: Options(headers: authHeader));

      if (res.statusCode == 200) {
        categoryList = (res.data['result'] as List<dynamic>).map((dynamic e) {
          return CategoryModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<CategoryModel>>.completed(categoryList);
      } else {
        return ApiResponse<List<CategoryModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<CategoryModel>>.error(de.error);
    } catch (e) {
      return ApiResponse<List<CategoryModel>>.error(e.toString());
    }
  }
}
