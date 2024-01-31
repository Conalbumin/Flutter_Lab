import 'package:flutter/material.dart';
import 'drawer.dart';
import 'app_bar.dart';
import 'body_content.dart';
import 'bottom_navigation_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _isLocked = false;
  bool _pageChangeByUser = false;

  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    BodyContent(bodyText: 'Home'),
    BodyContent(bodyText: 'History'),
    BodyContent(bodyText: 'Contact'),
    BodyContent(bodyText: 'Settings'),
    BodyContent(bodyText: 'Secret'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: CustomAppBar(
          isLocked: _isLocked,
          onLockerPressed: () {
            _onLocker(!_isLocked);
          },
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (_pageChangeByUser) {
              _onItemTapped(index);
            }
          },
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          isLocked: _isLocked,
        ),
        drawer: CustomDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageChangeByUser = false;
      _pageController.animateToPage(
        _selectedIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _onLocker(bool isLocked) {
    setState(() {
      _isLocked = isLocked;
      if (_isLocked && _selectedIndex == 4) {
        _onItemTapped(0);
      }
    });
  }
}
