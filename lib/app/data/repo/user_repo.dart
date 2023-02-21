import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/network_services/dio_client.dart';
import '../models/user_model.dart';

class UserRepository {
  List<String> getStates() => states;
  List<UserModel> userModelList = <UserModel>[];
  final Dio dio = Client().init();
  GetStorage storage = GetStorage();
  UserModel? userModel;
  Future<ApiResponse<Map<String, dynamic>>> checkUserExists() async {
    final dynamic token = await storage.read('token');
    log('tok in rep $token ');
    log('repo');
    try {
      final Response<Map<String, dynamic>> response = await dio.getUri(
        Uri.parse('user/profile'),
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
      );
      // final Response<Map<String, dynamic>> res =
      //     response.data!['result'] as Response<Map<String, dynamic>>;
      if (response.statusCode == 200) {
        return ApiResponse<Map<String, dynamic>>.completed(
            response.data!['result'] as Map<String, dynamic>);
        // log('sts code');
        // final data = response.data!['result'];
        // log('dsdsd code ${data}');
        // if (response.data!['result'].isBlank != true ||
        //     response.data!['result'] != null) {
        //   log('isblank');
        //   // userModelList =
        //   //     (response.data!['result'] as List<dynamic>).map((dynamic e) {
        //   //   return UserModel.fromjson(e as Map<String, String>);
        //   // }).toList();

        // } else {
        //   log('log  s ${response.statusMessage}');

        //   return ApiResponse<Map<String, dynamic>>.error(
        //       response.statusMessage);
        // }
        // // return ApiResponse<bool>.completed(
        // //   response.data as bool,
        // // );
      } else {
        log('else');

        return ApiResponse<Map<String, dynamic>>.error(
            response.statusMessage.toString());
      }
    } on DioError catch (d) {
      return ApiResponse<Map<String, dynamic>>.error(d.message);
    } catch (ex) {
      return ApiResponse<Map<String, dynamic>>.error(ex.toString());
    }
  }

  Future<ApiResponse<UserModel>> getUserDetails() async {
    final dynamic token = await storage.read('token');
    log('tok in rep $token ');
    log('repo');
    final Map<String, dynamic>? authHeader = await Client().getAuthHeader();
    try {
      final Response<Map<String, dynamic>> response = await dio.getUri(
        Uri.parse('user/profile'),
        options: Options(headers: authHeader),
      );
      // final Response<Map<String, dynamic>> res =
      //     response.data!['result'] as Response<Map<String, dynamic>>;
      if (response.statusCode == 200) {
        log('sts code');
        final UserModel user = UserModel.fromjson(
            response.data!['result'] as Map<String, dynamic>);
        // userModel =res.da
        //     (response.data!['result'] as List<dynamic>).map((dynamic e) {
        //   return UserModel.fromjson(e as Map<String, String>);
        // }).toList();
        return ApiResponse<UserModel>.completed(user);

        // return ApiResponse<bool>.completed(
        //   response.data as bool,
        // );
      } else {
        return ApiResponse<UserModel>.error(response.statusMessage.toString());
      }
    } on DioError catch (d) {
      return ApiResponse<UserModel>.error(d.message);
    } catch (ex) {
      return ApiResponse<UserModel>.error(ex.toString());
    }
  }

  // userDataList = (res.data!['result'] as List<dynamic>).map((dynamic e) {
  //         return UserModel.fromjson(e as Map<String, String>);

  Future<ApiResponse<Map<String, dynamic>>> signUpTheUser(
      UserModel user) async {
    try {
      final Map<String, dynamic>? autheHeader = await Client().getAuthHeader();
      log('auth hre $autheHeader');
      final Response<Map<String, dynamic>> res = await dio.postUri(
          Uri.parse('user/signup'),
          options: Options(headers: autheHeader),
          data: user.tojson());
      if (res.statusCode == 200) {
        log('200');

        return ApiResponse<Map<String, dynamic>>.completed(res.data);
      } else {
        log('adb');
        return ApiResponse<Map<String, dynamic>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      log('jnijk');
      return ApiResponse<Map<String, dynamic>>.error(de.error.toString());
    } catch (e) {
      log('fgs');
      return ApiResponse<Map<String, dynamic>>.error(e.toString());
    }
  }

  final List<String> states = <String>[
    'Select State',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'Uttar Pradesh',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli',
    'Daman and Diu',
    'Delhi',
    'Lakshadweep',
    'Puducherry',
  ];
}
