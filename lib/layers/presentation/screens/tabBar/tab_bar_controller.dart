import 'dart:io';
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
class TabBarController extends StatefulWidget {
  final List<TabBarItem> items;

  const TabBarController({Key? key, required this.items}) : super(key: key);

  @override
  _TabBarControllerState createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController> {
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late PageController _pageController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = List.generate(
      widget.items.length,
      (_) => GlobalKey<NavigatorState>(),
    );
    _pageController = PageController(initialPage: _selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (canPopNow, result) {
        if (_navigatorKeys[_selectedTab].currentState?.canPop() ?? canPopNow) {
          _navigatorKeys[_selectedTab].currentState?.pop();
        } else if (_selectedTab == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                contentPadding: EdgeInsets.zero,
                content: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.mainGradientColors,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(75),
                        blurRadius: 10,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.045),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Atenção",
                        style: TextStyle(
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 13),
                      Text(
                        "Deseja realmente sair?",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: screenWidth * 0.032,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.alertColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(180.0),
                              ),
                            ),
                            onPressed: () => exit(0),
                            child: Text(
                              "Sim",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.032,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.solidBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(180.0),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Não",
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: screenWidth * 0.032,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          setState(() {
            _selectedTab = 0;
            _pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.solidBackgroundColor,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              children: List.generate(
                widget.items.length,
                (index) => Navigator(
                  key: _navigatorKeys[index],
                  onGenerateRoute: (routeSettings) {
                    return MaterialPageRoute(
                      builder: (context) => widget.items[index].widget,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenWidth * 0.015,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: AppColors.tabBarGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedTab,
              selectedItemColor: AppColors.textColor,
              unselectedItemColor: AppColors.textColor.withAlpha(180),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconSize: screenWidth * 0.055,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.035,
              ),
              unselectedLabelStyle: TextStyle(fontSize: screenWidth * 0.025),
              onTap: (index) {
                if (index == _selectedTab) {
                  _navigatorKeys[index].currentState?.popUntil(
                    (route) => route.isFirst,
                  );
                } else {
                  setState(() {
                    _selectedTab = index;
                    _pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                }
              },
              items:
                  widget.items
                      .map(
                        (item) => BottomNavigationBarItem(
                          icon: Icon(item.icon),
                          label: item.title,
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarItem {
  final Widget widget;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  TabBarItem({
    required this.widget,
    this.navigatorkey,
    required this.title,
    required this.icon,
  });
}
