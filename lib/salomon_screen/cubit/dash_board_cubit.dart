import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:meta/meta.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();

  FutureOr<void> init() async {
    while(true) {
      try{
        final cb1 = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 3,
          sort: true,
        );
        final cb2 = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 4,
          sort: true,
        );
        final cb3 = await apiResponse.getOpsHistory(
          page: 0,
          size: 1,
          device: 5,
          sort: true,
        );
        emit(
          DashBoardLoaded(
            checkCB1: cb1 != [] ? cb1.first.status : false,
            checkCB2: cb2 != [] ? cb2.first.status : false,
            checkCB3: cb3 != [] ? cb3.first.status : false,
          ),
        );

        await Future.delayed(const Duration(seconds: 2));
      }
      catch(e) {
      }
    }
  }

  FutureOr<void> switchStatus({required bool status, required int device}) async {
    try{
      await apiResponse.switchStatus(status: status, device: device);

      final cb1 = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 3,
      );
      final cb2 = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 4,
      );
      final cb3 = await apiResponse.getOpsHistory(
        page: 0,
        size: 1,
        device: 5,
      );

      emit(
        DashBoardLoaded(
          checkCB1: cb1 != [] ? cb1.first.status : false,
          checkCB2: cb2 != [] ? cb2.first.status : false,
          checkCB3: cb3 != [] ? cb3.first.status : false,
        ),
      );
    }
    catch(e) {

    }
  }
}
