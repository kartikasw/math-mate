import 'package:math_mate/common/utils/enumeration/settings_menu_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsStateInitial()) {
    on<SettingsEventMenuClick>(_onSettingsEventMenuClick);
  }

  Future<void> _onSettingsEventMenuClick(
      SettingsEventMenuClick event, Emitter<SettingsState> emit) async {
    emit(SettingsStateMenuClicked(event.menu));
    emit(SettingsStateInitial());
  }
}
