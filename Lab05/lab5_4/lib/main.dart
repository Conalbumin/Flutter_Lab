import 'package:flutter/material.dart';
import 'steps.dart'; // Import the steps.dart file

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
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final postalCode = TextEditingController();

  // Function to validate the form fields in Personal and Shipping steps
  String? _validateFormField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void _continueButtonPressed() {
    final isLastStep = currentStep == getSteps(
      currentStep,
      firstName,
      lastName,
      address,
      postalCode,
      _formKey,
      _validateFormField,
    ).length - 1;

    // Validate the form fields
    if (_formKey.currentState!.validate()) {
      // Proceed to the next step or handle last step logic
      if (isLastStep) {
        // Handle last step logic
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thank you'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      currentStep = 0;
                      firstName.clear();
                      lastName.clear();
                      address.clear();
                      postalCode.clear();
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          currentStep += 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue)),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(
            currentStep,
            firstName,
            lastName,
            address,
            postalCode,
            _formKey,
              _validateFormField
          ), // Call getSteps from imported file
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepContinue: _continueButtonPressed,
          onStepCancel: currentStep == 0
              ? null
              : () {
            setState(() {
              currentStep -= 1;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep ==
                getSteps(
                  currentStep,
                  firstName,
                  lastName,
                  address,
                  postalCode,
                  _formKey,
                  _validateFormField,
                ).length -
                    1;
            return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      primary: isLastStep ? Colors.green : Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text(isLastStep ? 'Finish' : 'Next'),
                  ),
                  const SizedBox(width: 10),
                  if (currentStep != 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                      child: const Text('Back'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
