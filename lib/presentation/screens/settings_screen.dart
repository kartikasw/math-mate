import 'package:math_mate/common/utils/app_router.dart';
import 'package:math_mate/common/utils/enumeration/settings_menu_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/presentation/bloc/settings/settings_bloc.dart';
import 'package:math_mate/presentation/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocListener<SettingsBloc, SettingsState>(
          listener: _onSettingsBlocListener,
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: context.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: SettingsMenu.values.length,
              itemBuilder: (context, index) => SettingsButton(
                SettingsMenu.values[index],
                onTap: _onMenuClick,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onMenuClick(SettingsMenu menu) {
    BlocProvider.of<SettingsBloc>(context).add(SettingsEventMenuClick(menu));
  }

  Future<void> _onSettingsBlocListener(
      BuildContext context, SettingsState state) async {
    if (state is SettingsStateInitial) {
    } else if (state is SettingsStateMenuClicked) {
      switch (state.menu) {
        case SettingsMenu.calculatorSettings:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppRouter.calculatorSettings()),
          );
      }
    }
  }
}
