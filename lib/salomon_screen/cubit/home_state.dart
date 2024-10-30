part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<SensorDataEntity> listSensorData;
  final bool checkActiveTemperature;
  final bool checkActiveHumidity;
  final bool checkActiveLight;

  HomeLoaded({required this.listSensorData, required this.checkActiveTemperature, required this.checkActiveHumidity, required this.checkActiveLight});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}