import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/all_campi/All_campi_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/login_screen.dart/login_screen.dart';
import '../institute_screen/institute_screen.dart';
import 'package:ifg_mobile_estudante/layers/presentation/screens/tabBar/tab_bar_controller.dart';
import '../dedication_screen.dart/dedication_sreen.dart';
class MainTabBar extends StatelessWidget {
  const MainTabBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBarController(
      items: [
        TabBarItem(
          widget: const HomeScreenTab(),
          icon: Icons.house_rounded,
          title: 'Inicio',
        ),
        TabBarItem(
          widget: const InstituteScreenTab(),
          title: 'Instituição',
          icon: Icons.account_balance_rounded,
        ),
        TabBarItem(
          widget: const CampusScreenTab(),
          title: 'Campi',
          icon: Icons.travel_explore_rounded,
        ),
        TabBarItem(
          widget: const DedicationScreenTab(),
          title: 'Dedicatória',
          icon: Icons.favorite_rounded,
        ),
      ],
    );
  }
}

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoginScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class InstituteScreenTab extends StatefulWidget {
  const InstituteScreenTab({Key? key}) : super(key: key);

  @override
  _InstituteScreenTabState createState() => _InstituteScreenTabState();
}

class _InstituteScreenTabState extends State<InstituteScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InstituteScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class CampusScreenTab extends StatefulWidget {
  const CampusScreenTab({Key? key}) : super(key: key);

  @override
  _CampusScreenTabState createState() => _CampusScreenTabState();
}

class _CampusScreenTabState extends State<CampusScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AllCampiScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class DedicationScreenTab extends StatefulWidget {
  const DedicationScreenTab({Key? key}) : super(key: key);

  @override
  _DedicationScreenTabState createState() => _DedicationScreenTabState();
}

class _DedicationScreenTabState extends State<DedicationScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DedicationScreen();
  }

  @override
  bool get wantKeepAlive => true;
}
