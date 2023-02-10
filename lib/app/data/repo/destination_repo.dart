import 'package:dio/dio.dart';
import 'package:tour_maker/app/data/models/destinations_model.dart';
import 'package:tour_maker/app/services/network_services/dio_client.dart';

class DestinationRepository {
  final Dio dio = Client().init();
  List<DestinationsModel> destinationsList = [];
  Future<ApiResponse<List<DestinationsModel>>> getAllDestinations() async {
    try {
      final authorHeader = await Client().getAuthHeader();
      Response<dynamic> res = await dio.get('tours/destination',
          options: Options(headers: authorHeader));

      if (res.statusCode == 200) {
        destinationsList = (res.data['result'] as List<dynamic>).map((e) {
          return DestinationsModel.fromJson(e as Map<String, dynamic>);
        }).toList();
        return ApiResponse<List<DestinationsModel>>.completed(destinationsList);
      } else {
        return ApiResponse<List<DestinationsModel>>.error(res.statusMessage);
      }
    } on DioError catch (de) {
      return ApiResponse<List<DestinationsModel>>.error(de.error);
    } catch (e) {
      return ApiResponse<List<DestinationsModel>>.error(e.toString());
    }
  }
}
