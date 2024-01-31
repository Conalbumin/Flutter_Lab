import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final bool isLocked;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 35,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail),
          label: 'Contact',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
        if (!isLocked) // Show the "Secret" item only if not locked
          const BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Secret',
          ),
      ],
    );
  }
}
