import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final bool isLocked;

  CustomTabBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey.shade300,
      tabs: [
        const Tab(icon: Icon(Icons.home, size: 30), text: 'Home'),
        const Tab(icon: Icon(Icons.history, size: 30), text: 'History'),
        const Tab(icon: Icon(Icons.contact_mail, size: 30), text: 'Contact'),
        const Tab(icon: Icon(Icons.settings, size: 30), text: 'Setting'),
        if (!isLocked) // Show the "Secret" item only if not locked
          const Tab(
            icon: Icon(Icons.security),
            text: 'Secret',
          ),
      ],
      onTap: onItemTapped,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
