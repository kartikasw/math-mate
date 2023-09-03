import 'package:math_mate/common/utils/enumeration/main_menu_enum.dart';
import 'package:math_mate/common/utils/extensions.dart';
import 'package:math_mate/presentation/screens/calculator_screen.dart';
import 'package:math_mate/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: MainMenu.values.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTabBar(),
            _buildTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: MainMenu.values
          .map(
            (menu) => Tab(
              child: Text(menu.title, style: context.textTheme.titleMedium),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const <Widget>[CalculatorScreen(), SettingsScreen()],
      ),
    );
  }
}
