import 'package:math_mate/common/utils/enumeration/settings_menu_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsButton extends StatelessWidget {
  final SettingsMenu menu;
  final Function(SettingsMenu) onTap;

  const SettingsButton(this.menu, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(menu),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              child: SvgPicture.asset(
                menu.icon,
                width: 35,
                height: 35,
              ),
            ),
           const SizedBox(width: 15),
            Expanded(child: Text(menu.title, style: context.textTheme.titleMedium,))
          ],
        ),
      ),
    );
  }
}
