import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:map_test/src/features/location/data/models/building_model.dart';

class RemoteDatasource {
  final _dio = Dio();
  final String baseUrl = 'http://admin.smartalmaty.kz/api/v1/address/buildings/?limit=20&offset=60';

  Future<BuildingResponse> fetchBuildings() async {
    try {
      final response = await _dio.get(baseUrl);
      log(response.data.toString());
      return BuildingResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch buildings: $e');
    }
  }

}