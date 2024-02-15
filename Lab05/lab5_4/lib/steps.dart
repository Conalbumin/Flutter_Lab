import 'package:flutter/material.dart';

List<Step> getSteps(int currentStep, TextEditingController firstName,
    TextEditingController lastName, TextEditingController address,
    TextEditingController postalCode) {
  return [
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
            },
          ),
          TextFormField(
            controller: postalCode,
            decoration: const InputDecoration(
              labelText: 'Postal code',
              prefixIcon: Icon(Icons.code),
            ),
            onChanged: (value) {
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
}
