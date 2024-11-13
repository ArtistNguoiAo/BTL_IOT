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
    String? typeSearch,
    String? typeSort,
    String? dataSearch,
  }) async {
    emit(ListInfoLoading());
    try{
      String? type;
      bool? sort;

      if(typeSearch == 'Nhiệt độ') {
        type = 'temperature';
      }
      if(typeSearch == 'Độ ẩm') {
        type = 'humidity';
      }
      if(typeSearch == 'Ánh sáng') {
        type = 'light';
      }
      if(typeSearch == 'Thời gian') {
        type = 'time';
      }

      if(typeSort == 'Giảm dần') {
        sort = true;
      }
      else {
        sort = false;
      }

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
        type: type,
        sort: sort,
        dataSearch: dataSearch,
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
        type: type,
        sort: sort,
        dataSearch: dataSearch,
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
