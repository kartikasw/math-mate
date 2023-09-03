import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_mate/common/utils/failure.dart';
import 'package:math_mate/core/domain/model/history.dart';
import 'package:math_mate/core/domain/usecases/delete_history.dart';
import 'package:math_mate/core/domain/usecases/get_history_list.dart';
import 'package:math_mate/core/domain/usecases/insert_history.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final InsertHistory _insertHistory;
  final GetHistoryList _getHistoryList;
  final DeleteHistory _deleteHistory;

  HistoryBloc(this._insertHistory, this._getHistoryList, this._deleteHistory)
      : super(HistoryStateInitial(List<History>.empty())) {
    on<HistoryEventInsertHistory>(_onHistoryEventInsertHistory);
    on<HistoryEventGetHistoryList>(_onHistoryEventGetHistoryList);
    on<HistoryEventDeleteHistory>(_onHistoryEventDeleteHistory);
    on<HistoryEventHistoryDetailClick>(_onHistoryEventHistoryDetailClick);
    on<HistoryEventSeeMoreClick>(_onHistoryEventSeeMoreClick);
  }

  Future<void> _onHistoryEventInsertHistory(
      HistoryEventInsertHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryStateInsertHistoryLoading(state.list));
    Either<Failure, int> result = await _insertHistory.execute(event.history);
    result.fold(
      (failure) => emit(HistoryStateError(failure.message, state.list)),
      (result) => emit(HistoryStateInsertHistorySuccess(state.list)),
    );
  }

  Future<void> _onHistoryEventGetHistoryList(
    HistoryEventGetHistoryList event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryStateGetHistoryListLoading(state.list));
    Either<Failure, List<History>> result = await _getHistoryList.execute();
    result.fold(
      (failure) => emit(HistoryStateError(failure.message, state.list)),
      (result) => emit(HistoryStateGetHistoryListSuccess(result)),
    );
  }

  Future<void> _onHistoryEventDeleteHistory(
      HistoryEventDeleteHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryStateDeleteHistoryLoading(state.list));
    Either<Failure, int> result = await _deleteHistory.execute();
    result.fold(
      (failure) => emit(HistoryStateError(failure.message, state.list)),
      (result) => emit(HistoryStateDeleteHistorySuccess(const [])),
    );
  }

  Future<void> _onHistoryEventHistoryDetailClick(
    HistoryEventHistoryDetailClick event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryStateHistoryDetailClicked(event.history, state.list));
    emit(HistoryStateInitial(state.list));
  }

  Future<void> _onHistoryEventSeeMoreClick(
      HistoryEventSeeMoreClick event, Emitter<HistoryState> emit) async {
    emit(HistoryStateSeeMoreClicked(state.list));
    emit(HistoryStateInitial(state.list));
  }
}
