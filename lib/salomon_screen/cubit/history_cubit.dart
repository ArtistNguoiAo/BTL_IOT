import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/core/helper/global.dart';
import 'package:btl_iot/entity/ops_history_entity.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();

  FutureOr<void> init({required int page}) async {
    emit(HistoryLoading());
    try{
      final listOpsHistory = await apiResponse.getOpsHistory(
        page: page - 1,
        size: 10,
      );
      emit(
        HistoryLoaded(
          listOpsHistory: listOpsHistory,
          page: 1,
          totalPages: totalPagesOps,
        ),
      );
    }
    catch(e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  FutureOr<void> search({
    required int page,
    String? typeStatus,
    String? typeDevice,
    String? typeSort,
    String? dataSearch,
  }) async {
    emit(HistoryLoading());
    try{
      //check l1
      if(page > totalPagesOps) {
        page = totalPagesOps;
      }
      if(page == 0) {
        page = 1;
      }
      int? device;
      if(typeDevice == 'Điều hoà') {
        device = 0;
      }
      if(typeDevice == 'Quạt') {
        device = 1;
      }
      if(typeDevice == 'Đèn') {
        device = 2;
      }
      if(typeDevice == 'Thiết bị 1') {
        device = 3;
      }
      if(typeDevice == 'Thiết bị 2') {
        device = 4;
      }
      if(typeDevice == 'Thiết bị 3') {
        device = 5;
      }
      print('device: $device');
      await apiResponse.getOpsHistory(
        page: page - 1,
        size: 10,
        status: typeStatus != null ? typeStatus == 'ON' ? true : typeStatus == 'OFF' ? false : null : null,
        device: device,
        sort: typeSort != null ? typeSort == 'Giảm dần' ? true : false : null,
        dataSearch: dataSearch,
      );
      //check l2
      if(page > totalPagesOps) {
        page = totalPagesOps;
      }
      if(page == 0) {
        page = 1;
      }
      int? device2;
      if(typeDevice == 'Điều hoà') {
        device2 = 0;
      }
      if(typeDevice == 'Quạt') {
        device2 = 1;
      }
      if(typeDevice == 'Đèn') {
        device2 = 2;
      }
      if(typeDevice == 'Thiết bị 1') {
        device2 = 3;
      }
      if(typeDevice == 'Thiết bị 2') {
        device2 = 4;
      }
      if(typeDevice == 'Thiết bị 3') {
        device2 = 5;
      }
      final listOpsHistory = await apiResponse.getOpsHistory(
        page: page - 1,
        size: 10,
        status: typeStatus != null ? typeStatus == 'ON' ? true : typeStatus == 'OFF' ? false : null : null,
        device: device2,
        sort: typeSort != null ? typeSort == 'Giảm dần' ? true : false : null,
        dataSearch: dataSearch,
      );
      emit(
        HistoryLoaded(
          listOpsHistory: listOpsHistory,
          page: page,
          totalPages: totalPagesOps,
        ),
      );
    }
    catch(e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
