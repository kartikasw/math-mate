enum MainMenu {
  general('General'), settings('Settings');

  final String _title;

  String get title => _title;

  const MainMenu(this._title);
}