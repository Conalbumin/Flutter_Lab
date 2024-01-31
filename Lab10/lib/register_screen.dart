import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

const space = SizedBox(
  height: 16,
);

class _RegisterScreen extends State<RegisterScreen> {
  var _form = GlobalKey<FormState>();
  String fullName = '';

  void _submitForm() {
    if (_form.currentState?.validate() ?? false) {
      _form.currentState?.save();
      print(fullName);
    } else {
      print('Invalid form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Chat')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              SizedBox(
                height: 16,
              ),
              Text(
                'Join the ChatRoom',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 36,
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                onSaved: (v) => fullName = v ?? '',
                validator: (v) {
                  if (v?.trim().isEmpty ?? true) {
                    return 'Please enter full name';
                  } else if (v!.length < 4) {
                    return 'User name is too short';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your display name',
                  label: Text('Full Name'),
                ),
              ),
              space,
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: _submitForm,
                child: Text(
                  'Chat Now',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
