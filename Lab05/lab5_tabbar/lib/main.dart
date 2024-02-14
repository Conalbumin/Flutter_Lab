import 'package:flutter/material.dart';

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

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  var items = [
    {'text': 'Home', 'icon': Icons.home},
    {'text': 'History', 'icon': Icons.history},
    {'text': 'Settings', 'icon': Icons.settings},
  ];

  late var _controller = TabController(length: items.length, vsync: this);

  @override
  void initState() {
    _controller.addListener(() { 
      if(!_controller.indexIsChanging) {
        print('Change to tab: ${_controller.index}');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _createTabView(e) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        e['text'].toString(),
        style: const TextStyle(fontSize: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            int next = (_controller.index + 1) % items.length;
            _controller.animateTo(next);
          },
          child: const Icon(Icons.help_center),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text(
              'TabBar Example',
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottom: TabBar(
              controller: _controller,
              tabs: items
                  .map((e) => Tab(
                        text: e['text'].toString(),
                        icon: Icon(e['icon'] as IconData),
                      ))
                  .toList()),
        ),
        body: TabBarView(
            controller: _controller,
            children: items.map(_createTabView).toList()));
  }
}
