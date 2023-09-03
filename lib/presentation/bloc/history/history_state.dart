// ignore_for_file: must_be_immutable

part of 'history_bloc.dart';

class HistoryState extends Equatable {
  List<History> list;

  HistoryState(this.list);

  @override
  List<Object?> get props => [list];
}

class HistoryStateInitial extends HistoryState {
  HistoryStateInitial(super.list);
}

class HistoryStateInsertHistoryLoading extends HistoryState {
  HistoryStateInsertHistoryLoading(super.list);
}

class HistoryStateInsertHistorySuccess extends HistoryState {
  HistoryStateInsertHistorySuccess(super.list);
}

class HistoryStateGetHistoryListLoading extends HistoryState {
  HistoryStateGetHistoryListLoading(super.list);
}

class HistoryStateGetHistoryListSuccess extends HistoryState {
  HistoryStateGetHistoryListSuccess(super.list);
}

class HistoryStateDeleteHistoryLoading extends HistoryState {
  HistoryStateDeleteHistoryLoading(super.list);
}

class HistoryStateDeleteHistorySuccess extends HistoryState {
  HistoryStateDeleteHistorySuccess(super.list);
}

class HistoryStateSeeMoreClicked extends HistoryState {
  HistoryStateSeeMoreClicked(super.list);
}

class HistoryStateHistoryDetailClicked extends HistoryState {
  final History history;

  HistoryStateHistoryDetailClicked(this.history, super.list);

  @override
  List<Object?> get props => [history, list];
}

class HistoryStateError extends HistoryState {
  final String errMessage;

  HistoryStateError(this.errMessage, super.list);

  @override
  List<Object?> get props => [errMessage, list];
}
