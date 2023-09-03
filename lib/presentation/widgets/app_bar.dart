import 'package:math_mate/common/resources/colors.dart';
import 'package:flutter/material.dart';

class PrimaryAppBar extends AppBar {
  final BuildContext context;
  final String textTitle;
  final List<Widget>? actionWidgets;
  final Widget? leadingWidget;
  final Color? background;
  final Color? foreground;
  final Color? titleColor;

  PrimaryAppBar(this.context, this.textTitle,
      {this.actionWidgets,
      this.leadingWidget,
      this.background,
      this.foreground,
      this.titleColor = ColorRes.white,
      super.key})
      : super(
            elevation: 0,
            backgroundColor: background,
            foregroundColor: foreground,
            automaticallyImplyLeading: leadingWidget == null ? true : false,
            leading: leadingWidget,
            title: Text(
              textTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            actions: actionWidgets);
}
