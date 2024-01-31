import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _itemBuilder(context, index) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          const ListTile(
            title: Text('Title'),
            subtitle: Text('Subtitle'),
          ),
          Expanded(
              child: Image.network(
            'https://cdn.pixabay.com/photo/2022/04/08/07/18/facebook-7118901_640.png',
            fit: BoxFit.fill,
          )),
          ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Like')),
              TextButton(onPressed: () {}, child: Text('View'))
            ],
          )
        ],
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
          "Gridview Widget",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        color: Colors.grey.shade200,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 300,
            mainAxisSpacing: 7 , crossAxisSpacing: 7),
            itemBuilder: _itemBuilder,
            // separatorBuilder: (context, index) => Divider(
            //   thickness: 2,
            // ),
            itemCount: 20),
      ),
    );
  }
}
