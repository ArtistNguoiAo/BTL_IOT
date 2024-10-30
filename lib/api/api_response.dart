import 'dart:convert';

import 'package:btl_iot/core/helper/global.dart';
import 'package:btl_iot/entity/ops_history_entity.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  ApiResponse(this._client);

  final http.Client _client;

  final baseUrl = 'http://192.168.114.156:8080/api/v1';

  //final baseUrl = 'http://localhost:8080/api/v1';

  Future<void> switchStatus({required bool status, required int device}) async {
    final url = Uri.parse('$baseUrl/ops');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': status,
          'device': device,
        }),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<List<OpsHistoryEntity>> getOpsHistory({
    required int page,
    required int size,
    bool? status,
    int? device,
    String? startTime,
    String? endTime,
  }) async {
    var link = '$baseUrl/search-history-ops?page=$page&size=$size';
    if(status != null) {
      link += '&status=$status';
    }
    if(device != null) {
      link += '&device=$device';
    }
    if(startTime != null && endTime != null) {
      link += '&startTime=$startTime&endTime=$endTime';
    }
    final url = Uri.parse(link);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        totalPagesOps = data['totalPages'];
        return List<OpsHistoryEntity>.from(data['content'].map((x) => OpsHistoryEntity.fromJson(x)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<SensorDataEntity>> getSensorData({
    required int page,
    required int size,
    String? dataSearch,
    required double temperatureMin,
    required double temperatureMax,
    required double humidityMin,
    required double humidityMax,
    required double lightMin,
    required double lightMax,
    String? startTime,
    String? endTime,
  }) async {
    var link = '$baseUrl/search-sensor-data?page=$page&size=$size&temperatureMin=$temperatureMin&temperatureMax=$temperatureMax&humidityMin=$humidityMin&humidityMax=$humidityMax&lightMin=$lightMin&lightMax=$lightMax';
    if(dataSearch != null) {
      link += '&dataSearch=$dataSearch';
    }
    if(startTime != null && endTime != null) {
      link += '&startTime=$startTime&endTime=$endTime';
    }
    final url = Uri.parse(link);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        totalPagesData = data['totalPages'];
        return List<SensorDataEntity>.from(data['content'].map((x) => SensorDataEntity.fromJson(x)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}