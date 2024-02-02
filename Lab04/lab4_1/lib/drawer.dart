import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onDrawerItemTapped;

  CustomDrawer({required this.selectedIndex, required this.onItemTapped, required this.onDrawerItemTapped});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/round-avatar-with-young-man-free-vector.jpg'),
                  radius: 40,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ), // Name
                    Text(
                      'mail@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ) // Email
                  ],
                )
              ],
            )

          ),
          ListTile(
            title: const Text('Home'),
            selected: selectedIndex == 0,
            onTap: () {
              onItemTapped(0);
              onDrawerItemTapped();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('History'),
            selected: selectedIndex == 1,
            onTap: () {
              onItemTapped(1);
              onDrawerItemTapped();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Contact'),
            selected: selectedIndex == 2,
            onTap: () {
              onItemTapped(2);
              onDrawerItemTapped();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Setting'),
            selected: selectedIndex == 3,
            onTap: () {
              onItemTapped(3);
              onDrawerItemTapped();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}