import 'package:flutter/material.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

const space = SizedBox(
  height: 16,
);

class _RegisterScreenState extends State<RegisterScreen> {
  var _form = GlobalKey<FormState>();
  String fullName = '';

  void _submitForm(BuildContext context) {
    if (_form.currentState?.validate() ?? false) {
      _form.currentState?.save();
      print(fullName);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen(userName: fullName)),
      );
    } else {
      print('Invalid form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Chat', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue,),
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
                  labelText: 'Full Name', // Changed from label to labelText
                ),
              ),
              space,
              ElevatedButton(
                style:
                ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50), backgroundColor: Colors.blue),
                onPressed: () => _submitForm(context), // Pass context to _submitForm
                child: Text(
                  'Chat Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
