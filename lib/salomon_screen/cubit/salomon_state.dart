part of 'salomon_cubit.dart';

@immutable
sealed class SalomonState {}

final class SalomonInitial extends SalomonState {}

final class SalomonLoaded extends SalomonState {
  final int currentIndex;

  SalomonLoaded({
    required this.currentIndex,
  });
}