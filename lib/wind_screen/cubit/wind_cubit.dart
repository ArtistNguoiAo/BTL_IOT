import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:meta/meta.dart';

part 'wind_state.dart';

class WindCubit extends Cubit<WindState> {
  WindCubit() : super(WindInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();

  FutureOr<void> init() async {
    while(true) {
      try{
        final listSensorData = await apiResponse.getSensorData(
          page: 0,
          size: 10,
          sort: true,
        );

        final wind = listSensorData[0].wind;

        emit(
          WindLoaded(
            listSensorDataEntity: listSensorData,
            wind: wind,
            check: double.parse(wind) >= 60 ? true : false,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
      }
      catch(e) {
        emit(WindError(message: e.toString()));
      }
    }
  }
}
