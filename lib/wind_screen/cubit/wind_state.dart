part of 'wind_cubit.dart';

@immutable
sealed class WindState {}

final class WindInitial extends WindState {}

final class WindLoading extends WindState {}

final class WindLoaded extends WindState {
  final List<SensorDataEntity> listSensorDataEntity;
  final String wind;
  final bool check;

  WindLoaded({
    required this.listSensorDataEntity,
    required this.wind,
    required this.check,
  });
}

final class WindError extends WindState {
  final String message;

  WindError({
    required this.message,
  });
}