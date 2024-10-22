part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final List<OpsHistoryEntity> listOpsHistory;
  final int page;
  final int totalPages;

  HistoryLoaded({required this.listOpsHistory, required this.page, required this.totalPages});
}

final class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}