import 'package:flutter/material.dart';
import 'drawer.dart';
import 'app_bar.dart';
import 'body_content.dart';
import 'bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static int getTabLength(bool isLocked) {
    return isLocked ? 4 : 5;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: getTabLength(false),
        child: _MyApp(),
      ),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isLocked = false;
  bool _pageChangeByUser = false;
  bool _drawerItemSelected = false;

  late TabController _tabController;

  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    BodyContent(bodyText: 'Home'),
    BodyContent(bodyText: 'History'),
    BodyContent(bodyText: 'Contact'),
    BodyContent(bodyText: 'Setting'),
    BodyContent(bodyText: 'Secret'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: MyApp.getTabLength(_isLocked), vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_drawerItemSelected && _tabController.index != _selectedIndex) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
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

      _tabController.animateTo(index);
    });
  }

  void _onLocker(bool isLocked) {
    setState(() {
      _isLocked = isLocked;
      int tabLength = MyApp.getTabLength(_isLocked);
      if (_isLocked && _selectedIndex >= tabLength) {
        // If the selected index is out of bounds, set it to the last valid index
        _selectedIndex = tabLength - 1;
        _pageController.jumpToPage(_selectedIndex);
      }

      _tabController.length = tabLength;
    });
  }


  void _onPageChanged(int index) {
    if (!_pageChangeByUser) {
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    int tabLength = MyApp.getTabLength(_isLocked);

    return DefaultTabController(
      length: tabLength,
      child: Scaffold(
        appBar: CustomAppBar(
          isLocked: _isLocked,
          onLockerPressed: () {
            _onLocker(!_isLocked);
          },
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          tabController: _tabController,
          tabLength: tabLength,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: (index) {
            _onItemTapped(index);
            _tabController.animateTo(index);
          },
          isLocked: _isLocked,
        ),
        drawer: CustomDrawer(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          onDrawerItemTapped: () {
            setState(() {
              _drawerItemSelected = true;
            });
          },
        ),
      ),
    );
  }
}
