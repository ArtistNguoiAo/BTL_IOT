import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();

  FutureOr<void> init() async {
    while(true) {
      try{
        final listSensorData = await apiResponse.getSensorData(
          page: 0,
          size: 10,
          sort: true,
        );

        final temperature = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 0,
          sort: true,
        );
        final humidity = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 1,
          sort: true,
        );
        final light = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 2,
          sort: true,
        );
        emit(
          HomeLoaded(
            listSensorData: listSensorData,
            checkActiveTemperature: temperature != [] ? temperature.first.status : false,
            checkActiveHumidity: humidity != [] ? humidity.first.status : false,
            checkActiveLight: light != [] ? light.first.status : false,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
      }
      catch(e) {
        emit(HomeError(message: e.toString()));
      }
    }
  }

  FutureOr<void> switchStatus({required bool status, required int device}) async {
    try{
      await apiResponse.switchStatus(status: status, device: device);

      final listSensorData = await apiResponse.getSensorData(
        page: 0,
        size: 10,
      );

      final temperature = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 0,
      );
      final humidity = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 1,
      );
      final light = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 2,
      );

      emit(
        HomeLoaded(
          listSensorData: listSensorData,
          checkActiveTemperature: temperature != [] ? temperature.first.status : false,
          checkActiveHumidity: humidity != [] ? humidity.first.status : false,
          checkActiveLight: light != [] ? light.first.status : false,
        ),
      );
    }
    catch(e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
