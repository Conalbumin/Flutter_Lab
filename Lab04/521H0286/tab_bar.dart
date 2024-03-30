import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final bool isLocked;

  CustomTabBar({
    required this.tabController,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isLocked,
  });

  static int getTabLength(bool isLocked) {
    return isLocked ? 4 : 5;
  }

  List<Tab> _buildTabs() {
    List<Tab> tabs = [
      const Tab(icon: Icon(Icons.home, size: 30), text: 'Home'),
      const Tab(icon: Icon(Icons.history, size: 30), text: 'History'),
      const Tab(icon: Icon(Icons.contact_mail, size: 30), text: 'Contact'),
      const Tab(icon: Icon(Icons.settings, size: 30), text: 'Setting'),
    ];

    if (!isLocked) {
      tabs.add(const Tab(
        icon: Icon(Icons.security),
        text: 'Secret',
      ));
    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey.shade300,
      tabs: _buildTabs(),
      onTap: (index) {
        int tabLength = getTabLength(isLocked);
        onItemTapped(index >= tabLength ? 0 : index);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
