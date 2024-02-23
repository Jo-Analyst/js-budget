import 'package:flutter/material.dart';
import 'package:js_budget/src/home/home_page.dart';
import 'package:js_budget/src/app/widgets/bottom_navigation_bar_item._widget.dart';

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
        // controller: _pageController,
        onPageChanged: setCurrentPage,
        children: [
          const HomePage(),
          Container(color: Colors.red),
          Container(color: Colors.blue),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedFontSize: 18,
        unselectedFontSize: 16,
        unselectedItemColor: Colors.black87,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green,
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
