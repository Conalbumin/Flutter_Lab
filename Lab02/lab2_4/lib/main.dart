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
  double _currentHeight = 170;
  double _currentWeight = 60;
  double _currentAge = 18;

  void _clearValues() {
    setState(() {
      _currentHeight = 170;
      _currentWeight = 60;
      _currentAge = 18;
    });
  }

  void _calculateBMI() {
    double bmi =
        _currentWeight / ((_currentHeight / 100) * (_currentHeight / 100));
    // Hiển thị giá trị BMI bằng cách sử dụng Dialog hoặc Navigator.push
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('BMI Result'),
        content: Text('Your BMI is: ${bmi.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GFG Custom Widget',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7D7E8C85),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'FEMALE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 190,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7D7E8C85),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'MALE',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ), // FEMALE, MALE

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 390,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7D7E8C85),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT ${_currentHeight.toInt()} cm',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Slider(
                        value: _currentHeight,
                        min: 100.0,
                        max: 250.0,
                        onChanged: (value) {
                          setState(() {
                            _currentHeight = value;
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ), // HEIGHT

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7D7E8C85),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WEIGHT ${_currentWeight.toInt()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_up,
                                    color: Colors.white, size: 40),
                                onPressed: () {
                                  setState(() {
                                    _currentWeight += 1;
                                  });
                                },
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.white, size: 40),
                                onPressed: () {
                                  setState(() {
                                    _currentWeight -= 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 190,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7D7E8C85),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AGE ${_currentAge.toInt()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_up,
                                    color: Colors.white, size: 40),
                                onPressed: () {
                                  setState(() {
                                    _currentAge += 1;
                                  });
                                },
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.white, size: 40),
                                onPressed: () {
                                  setState(() {
                                    _currentAge -= 1;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ), // WEIGHT, AGE

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0x7DFDF7F7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: _clearValues,
                    child: const Text(
                      'CLEAR',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 190,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: _calculateBMI,
                    child: const Text(
                      'GET BMI',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ), // CLEAR, GET BMI
            const SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0x7D7E8C85),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
