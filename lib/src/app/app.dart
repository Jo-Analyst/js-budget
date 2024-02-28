import 'package:flutter/material.dart';
import 'package:js_budget/src/pages/finance/finance_page.dart';
import 'package:js_budget/src/pages/home/home_page.dart';
import 'package:js_budget/src/pages/menu/menu_page.dart';
import 'package:js_budget/src/app/widgets/bottom_navigation_bar_item_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void setCurrentPage(currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: setCurrentPage,
        children: const [
          HomePage(),
          FinancePage(),
          MenuPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedFontSize: 18,
        unselectedFontSize: 16,
        unselectedItemColor: Colors.black87,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: textStyleSmallDefault,
        unselectedLabelStyle: textStyleSmallDefault,
        fixedColor: Colors.deepPurple,
        currentIndex: _currentIndex,
        onTap: (page) => _pageController.animateToPage(
          page,
          duration: const Duration(microseconds: 400),
          curve: Curves.ease,
        ),
        items: BottomNavigationBarItemWidget.items(),
      ),
    );
  }
}
