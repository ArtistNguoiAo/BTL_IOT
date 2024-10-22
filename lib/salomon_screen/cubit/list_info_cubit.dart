import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/core/helper/global.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:meta/meta.dart';

part 'list_info_state.dart';

class ListInfoCubit extends Cubit<ListInfoState> {
  ListInfoCubit() : super(ListInfoInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();

  FutureOr<void> init({required int page}) async {
    emit(ListInfoLoading());
    try{
      final listSensorData = await apiResponse.getSensorData(
        page: page - 1,
        size: 10,
        temperatureMin: 0,
        temperatureMax: 100,
        humidityMin: 0,
        humidityMax: 100,
        lightMin: 0,
        lightMax: 4095,
      );
      emit(
        ListInfoLoaded(
          listSensorData: listSensorData,
          page: 1,
          totalPages: totalPagesData,
        ),
      );
    }
    catch(e) {
      emit(ListInfoError(message: e.toString()));
    }
  }

  FutureOr<void> search({
    required int page,
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
    emit(ListInfoLoading());
    try{
      //check l1
      if(page > totalPagesData) {
        page = totalPagesData;
      }
      if(page == 0) {
        page = 1;
      }
      await apiResponse.getSensorData(
        page: page - 1,
        size: 10,
        dataSearch: dataSearch,
        temperatureMin: temperatureMin,
        temperatureMax: temperatureMax,
        humidityMin: humidityMin,
        humidityMax: humidityMax,
        lightMin: lightMin,
        lightMax: lightMax,
        startTime: startTime,
        endTime: endTime,
      );
      //check l2
      if(page > totalPagesData) {
        page = totalPagesData;
      }
      if(page == 0) {
        page = 1;
      }
      final listSensorData = await apiResponse.getSensorData(
        page: page - 1,
        size: 10,
        dataSearch: dataSearch,
        temperatureMin: temperatureMin,
        temperatureMax: temperatureMax,
        humidityMin: humidityMin,
        humidityMax: humidityMax,
        lightMin: lightMin,
        lightMax: lightMax,
        startTime: startTime,
        endTime: endTime,
      );
      emit(
        ListInfoLoaded(
          listSensorData: listSensorData,
          page: page,
          totalPages: totalPagesData,
        ),
      );
    }
    catch(e) {
      emit(ListInfoError(message: e.toString()));
    }
  }
}
