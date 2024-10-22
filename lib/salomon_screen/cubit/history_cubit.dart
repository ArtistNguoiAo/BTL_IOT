import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/api/api_response.dart';
import 'package:btl_iot/core/di/config_di.dart';
import 'package:btl_iot/core/helper/global.dart';
import 'package:btl_iot/core/helper/string_helper.dart';
import 'package:btl_iot/entity/ops_history_entity.dart';
import 'package:btl_iot/salomon_screen/view/fake_data.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  final ApiResponse apiResponse = ConfigDI().injector.get();


  FutureOr<void> init({required int page}) async {
    emit(HistoryLoading());
    try{
      final listOpsHistory = await apiResponse.getOpsHistory(
        page: page,
        size: 10,
      );
      emit(
        HistoryLoaded(
          listOpsHistory: listOpsHistory,
          page: 0,
          totalPages: totalPagesOps,
        ),
      );
    }
    catch(e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  FutureOr<void> search({
    int? page,
    String? status,
    String? device,
    String? startTime,
    String? endTime,
  }) async {
    final currentState = state as HistoryLoaded;
    emit(HistoryLoading());
    try{
      final listOpsHistory = await apiResponse.getOpsHistory(
        page: page ?? currentState.page,
        size: 10,
        status: status != null ? status == 'ON' ? true : status == 'OFF' ? false : null : null,
        device: device != null ? device == 'Điều hoà' ?  0 : device == 'Quạt' ? 1 : device == 'Đèn' ? 2 : null : null,
        startTime: startTime,
        endTime: endTime,
      );
      emit(
        HistoryLoaded(
          listOpsHistory: listOpsHistory,
          page: 0,
          totalPages: totalPagesOps,
        ),
      );
    }
    catch(e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
