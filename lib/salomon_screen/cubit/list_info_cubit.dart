import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:meta/meta.dart';

part 'list_info_state.dart';

class ListInfoCubit extends Cubit<ListInfoState> {
  ListInfoCubit() : super(ListInfoInitial());

  FutureOr<void> init() async {
    emit(ListInfoLoading());
    await Future.delayed(const Duration(seconds: 2));

  }
}
