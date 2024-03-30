import 'package:flutter/material.dart';

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
  String password = '';
  bool obscurePassword = true;
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;
  bool _formSubmitted = false;

  void _handleSubmit() {
    setState(() {
      _formSubmitted = true;
    });

    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Server is busy, try again later'),
          ),
        );
        _key.currentState?.reset();
        setState(() {
          _formSubmitted = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "Basic Form",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _key,
                autovalidateMode: _formSubmitted
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'User Registration',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
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
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        prefixIcon: Icon(Icons.contact_mail_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
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
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (v) {
                        age = v != null ? int.parse(v) : 18;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your age';
                        if (int.parse(value) < 18 || int.parse(value) > 100)
                          return 'You must be older than 17 and younger than 100';
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        hintText: 'Enter your age',
                        prefixIcon: Icon(Icons.accessibility_sharp),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      onSaved: (value) {
                        country = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please choose your country';
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        hintText: 'Choose your country',
                        prefixIcon: Icon(Icons.language),
                        border: OutlineInputBorder(),
                      ),
                      items: <String>[
                        'USA',
                        'Canada',
                        'UK',
                        'Australia',
                        'Vietnam',
                        'Laos',
                        'Cambodia'
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
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (v) {
                        password = v ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter your password';
                        if (value.length < 6)
                          return 'Password must contain at least 6 characters';
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
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
                      'Connecting to backend server',
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
