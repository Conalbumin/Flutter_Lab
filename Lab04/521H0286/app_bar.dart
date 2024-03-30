import 'package:flutter/material.dart';
import 'tab_bar.dart';

class CustomAppBar extends AppBar {
  final bool isLocked;
  final VoidCallback onLockerPressed;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final TabController tabController;

  CustomAppBar({
    required this.isLocked,
    required this.onLockerPressed,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.tabController,
    required int tabLength,
  }) : super(
    backgroundColor: Colors.blue,
    title: const Text(
      'Bottom NavBar',
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    actions: [
      IconButton(
        onPressed: onLockerPressed,
        icon: Icon(
          isLocked ? Icons.lock : Icons.lock_open,
          color: Colors.white,
          size: 30,
        ),
      )
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(kTextTabBarHeight + 30.0), // Adjust the padding as needed
      child: Padding(
        padding: const EdgeInsets.all(0.0), // Adjust the padding as needed
        child: CustomTabBar(
          tabController: tabController,
          isLocked: isLocked,
          selectedIndex: selectedIndex,
          onItemTapped: onItemTapped,
        ),

      ),
    ),
  );
}
