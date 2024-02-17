import 'package:flutter/material.dart';
import 'country.dart';
import 'job.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _key = GlobalKey<FormState>();
  String username = '';
  String email = '';
  int age = 18;
  String country = '';
  String job = '';
  bool obscurePassword = true;
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();

  void _handleSubmit() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      // Simulate sending data to the server
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Server is busy, try again later'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Flutter Dialog",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _nameFocus,
                      onSaved: (v) {
                        username = v ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your username';
                        if (value.length < 6)
                          return 'Username must contain at least 6 characters';
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        hintText: 'Enter your username',
                        border: OutlineInputBorder(),
                      ),
                    ), // Name

                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (v) {
                        email = v ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your email';
                        if (!value.contains('@'))
                          return 'This is not a valid email';
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ), // Email
                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      onSaved: (value) {
                        country = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please choose your country';
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Your country',
                        hintText: 'Choose your country',
                        border: OutlineInputBorder(),
                      ),
                      items: countriesList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          country = value ?? '';
                        });
                      },
                    ), // Country
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        selectDate(context, _selectedDate, (DateTime date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        });
                      },
                      child: AbsorbPointer(
                        child: DropdownButtonFormField<String>(
                          onSaved: (value) {
                            _selectedDate = value != null ? DateTime.parse(value) : DateTime.now(); // Assuming value is a String representation of a DateTime
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Please choose your birthday';
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Birthday',
                            hintText: 'DD:MM:YY',
                            border: OutlineInputBorder(),
                          ),
                          items: <String>[
                            'Date Picker'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedDate = value != null ? DateTime.parse(value) : DateTime.now(); // Assuming value is a String representation of a DateTime
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        selectTime(context, _selectedTime, (TimeOfDay time) {
                          setState(() {
                            _selectedTime = time;
                          });
                        });
                      },
                      child: AbsorbPointer(
                        child: DropdownButtonFormField<String>(
                          onSaved: (value) {
                            country = value ?? '';
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please choose your country';
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Birthtime',
                            hintText: 'HH:MM',
                            border: OutlineInputBorder(),
                          ),
                          items: <String>[
                            'Time Picker'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              country = value ?? '';
                            });
                          },
                        ),
                      ),
                    ), // Birthtime
                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      onSaved: (value) {
                        job = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please choose your job';
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Job',
                        hintText: 'Select your job',
                        border: OutlineInputBorder(),
                      ),
                      items: jobs.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          job = value ?? '';
                        });
                      },
                    ),
                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () {
                        // Trigger validation when the button is pressed
                        _handleSubmit();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50)),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Loading screen
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Submitting Data...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
