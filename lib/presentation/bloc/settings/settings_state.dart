part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsStateInitial extends SettingsState {}

class SettingsStateMenuClicked extends SettingsState {
  final SettingsMenu menu;

  SettingsStateMenuClicked(this.menu);
}
