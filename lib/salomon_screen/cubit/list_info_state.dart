part of 'list_info_cubit.dart';

@immutable
sealed class ListInfoState {}

final class ListInfoInitial extends ListInfoState {}

final class ListInfoLoading extends ListInfoState {}

final class ListInfoLoaded extends ListInfoState {
  final List<SensorDataEntity> listSensorData;
  final int page;
  final int totalPages;

  ListInfoLoaded({required this.listSensorData, required this.page, required this.totalPages});
}

final class ListInfoError extends ListInfoState {
  final String message;

  ListInfoError({required this.message});
}