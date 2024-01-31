import 'package:flutter/material.dart';
import 'drawer.dart';
import 'app_bar.dart';
import 'body_content.dart';
import 'bottom_navigation_bar.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultTabController(
      length: MyApp.getTabLength(false), // Assuming initially not locked
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static int getTabLength(bool isLocked) {
    return isLocked ? 4 : 5;
  }

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
    BodyContent(bodyText: 'Setting'),
    BodyContent(bodyText: 'Secret'),
  ];

  @override
  Widget build(BuildContext context) {
    int tabLength = MyApp.getTabLength(_isLocked);

    return Scaffold(
      appBar: CustomAppBar(
        isLocked: _isLocked,
        onLockerPressed: () {
          _onLocker(!_isLocked);
        },
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        // Pass tabLength to CustomAppBar
        tabLength: tabLength,
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
      int tabLength = MyApp.getTabLength(_isLocked);

      if (_isLocked && _selectedIndex == 4) {
        _onItemTapped(0);
        DefaultTabController.of(context)?.index = 0;
      }

      // Update the length of DefaultTabController dynamically
      DefaultTabController.of(context)?.length = tabLength;
    });
  }
}
