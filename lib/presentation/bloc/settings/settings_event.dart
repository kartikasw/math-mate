part of 'settings_bloc.dart';

class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsEventMenuClick extends SettingsEvent {
  final SettingsMenu menu;

  SettingsEventMenuClick(this.menu);
}
