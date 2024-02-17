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
  final _key = GlobalKey<FormState>();
  String username = '';
  String email = '';
  int age = 18;
  String country = '';
  String job = '';
  bool obscurePassword = true;
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

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
                        if (value == null || value.isEmpty) return 'Please enter your username';
                        if (value.length < 6) return 'Username must contain at least 6 characters';
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
                        if (value == null || value.isEmpty) return 'Please enter your email';
                        if (!value.contains('@')) return 'This is not a valid email';
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
                        border: OutlineInputBorder(),
                      ),
                      items: countriesList
                          .map<DropdownMenuItem<String>>((String value) {
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

                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await selectDate(
                            context, _selectedDate);
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                            _dateController.text = picked
                                .toString()
                                .split(' ')[0]; // Showing only the date part
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Birthday',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down)),
                    ), // Birthday
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? picked = await selectTime(
                            context, _selectedTime);
                        if (picked != null) {
                          setState(() {
                            _selectedTime = picked;
                            _timeController.text =
                                picked.format(context); // Showing the formatted time
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Birthtime',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down)),
                    ), // Birthtime
                    const SizedBox(height: 20),

                    TextFormField(
                      readOnly: true,
                      controller: TextEditingController(text: job),
                      onTap: () async {
                        String? selectedJob = await showJobDialog(context);
                        if (selectedJob != null) {
                          setState(() {
                            job = selectedJob;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Job',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.arrow_drop_down)), // Job
                    ),
                    const SizedBox(height: 20),

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
