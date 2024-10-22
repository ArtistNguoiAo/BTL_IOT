part of 'list_info_cubit.dart';

@immutable
sealed class ListInfoState {}

final class ListInfoInitial extends ListInfoState {}

final class ListInfoLoading extends ListInfoState {}

final class ListInfoLoaded extends ListInfoState {
  final List<SensorDataEntity> listSensorDataEntity;
  final String keyword;
  final String condition;

  ListInfoLoaded({required this.listSensorDataEntity, required this.keyword, required this.condition});
}

final class ListInfoError extends ListInfoState {
  final String message;

  ListInfoError(this.message);
}