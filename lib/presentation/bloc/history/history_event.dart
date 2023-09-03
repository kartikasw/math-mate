part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryEventInsertHistory extends HistoryEvent {
  final History history;

  HistoryEventInsertHistory(this.history);
}

class HistoryEventGetHistoryList extends HistoryEvent {}

class HistoryEventDeleteHistory extends HistoryEvent {}

class HistoryEventSeeMoreClick extends HistoryEvent {}

class HistoryEventHistoryDetailClick extends HistoryEvent {
  final History history;

  HistoryEventHistoryDetailClick(this.history);
}
