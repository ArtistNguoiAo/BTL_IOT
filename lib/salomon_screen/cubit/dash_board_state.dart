part of 'dash_board_cubit.dart';

@immutable
sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}

final class DashBoardLoaded extends DashBoardState {
  final bool checkCB1;
  final bool checkCB2;
  final bool checkCB3;

  DashBoardLoaded({required this.checkCB1, required this.checkCB2, required this.checkCB3});
}