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
  int currentStep = 0;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final postalCode = TextEditingController();

  String _validateInputs() {
    if(firstName.text.isEmpty) return 'Please enter first name';
    if(lastName.text.isEmpty) return 'Please enter last name';
    if(address.text.isEmpty) return 'Please enter address';
    if(postalCode.text.isEmpty) return 'Please enter postal code';
    return '';
  }

  List<Step> getSteps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text('Personal'),
      content: Column(
        children: <Widget>[
          TextFormField(
            validator: (firstName) {
              if (firstName == null || firstName.isEmpty)
                return 'Please enter your firstname';
              return null;
            },
            controller: firstName,
            decoration: const InputDecoration(
              labelText: 'Firstname',
              prefixIcon: Icon(Icons.person),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextFormField(
            validator: (lastName) {
              if (lastName == null || lastName.isEmpty)
                return 'Please enter your lastname';
              return null;
            },
            controller: lastName,
            decoration: const InputDecoration(
              labelText: 'Lastname',
              prefixIcon: Icon(Icons.drive_file_rename_outline),
            ),
            onChanged: (value) {
              setState(() {});
            },
          )
        ],
      ),
    ), //Personal
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      title: const Text('Shipping'),
      content: Column(
        children: <Widget>[
          TextFormField(
            controller: address,
            decoration: const InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.car_repair),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          TextFormField(
            controller: postalCode,
            decoration: const InputDecoration(
              labelText: 'Postal code',
              prefixIcon: Icon(Icons.code),
            ),
            onChanged: (value) {
              setState(() {});
            },
          )
        ],
      ),
    ), //Shipping
    Step(
      isActive: currentStep >= 2,
      title: const Text('Confirm'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Firstname: ${firstName.text}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Lastname: ${lastName.text}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Address: ${address.text}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Postal code: ${postalCode.text}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ) // Confirm
  ];

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
          steps: getSteps(),
          currentStep: currentStep,
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
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
          },
          onStepCancel: currentStep == 0
              ? null
              : () {
            setState(() {
              currentStep -= 1;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
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