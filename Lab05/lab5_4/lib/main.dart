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

  List<Step> getSteps() => [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      title: const Text('Personal'),
      content: Column(
        children: <Widget>[
          TextFormField(
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
    ),
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
    ),
    Step(
      isActive: currentStep >= 2,
      title: const Text('Confirm'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Firstname: ${firstName.text}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Lastname: ${lastName.text}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Address: ${address.text}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Postal code: ${postalCode.text}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4'),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.blue)),
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
                    content: Text(
                      'Firstname: ${firstName.text}\n'
                          'Lastname: ${lastName.text}\n'
                          'Address: ${address.text}\n'
                          'Postal code: ${postalCode.text}',
                    ),
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
            if (currentStep == 0) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: onStepContinue,
                    child: const Text('Next'),
                  ),
                ],
              );
            } else if (currentStep == getSteps().length - 1) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: onStepContinue,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Finish',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Back'),
                  ),
                  TextButton(
                    onPressed: onStepContinue,
                    child: const Text('Next'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
