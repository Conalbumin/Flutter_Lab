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

class _MyAppState extends State<MyApp> {
  var colors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100
  ];
  var _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPage(String label, Color color) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'PageView Widget',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: PageView.builder(
          controller: _controller,
          itemCount: 20,
          itemBuilder: (ct, idx) =>
              _buildPage('Item ${idx + 1}', colors[idx % colors.length])),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.ads_click),
        onPressed: () {
          int idx = _controller.page?.toInt() ?? 0;
          idx = (idx + 1) % 20;
          _controller.animateToPage(idx,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
    );
  }
}
