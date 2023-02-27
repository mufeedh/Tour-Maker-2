import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/network_services/dio_client.dart';
import '../models/wishlist_model.dart';

class WishListRepo {
  final Dio dio = Client().init();
  List<WishListModel> wishList = <WishListModel>[];

  Future<ApiResponse<List<WishListModel>>> getAllFav() async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.getUri(
          Uri.parse('user/favourites'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        log('hi rep ${res.data}');

        wishList = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return WishListModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('hi val ${wishList.length}');
        return ApiResponse<List<WishListModel>>.completed(wishList);
      } else {
        log('message ${res.statusMessage}');
        return ApiResponse<List<WishListModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<WishListModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<WishListModel>>.error(e.toString());
    }
  }

  Future<ApiResponse<List<WishListModel>>> createFav(int id) async {
    try {
      final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('user/create_favourites?id=$id'),
          options: Options(headers: authHeader));
      if (res.statusCode == 200) {
        wishList = (res.data!['result'] as List<dynamic>).map((dynamic e) {
          return WishListModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        log('hi rep ${res.data}');

        log('hi val ${wishList.length}');

        return ApiResponse<List<WishListModel>>.completed(wishList);
      } else {
        return ApiResponse<List<WishListModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<WishListModel>>.error(de.error.toString());
    } catch (e) {
      return ApiResponse<List<WishListModel>>.error(e.toString());
    }
  }
}
