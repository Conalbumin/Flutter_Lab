import 'package:flutter/material.dart';

List<String> jobs = ['Engineer', 'Doctor', 'Teacher', 'Artist', 'Other'];

Future<String?> showJobDialog(BuildContext context) async {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select your job'),
        content: SingleChildScrollView(
          child: ListBody(
            children: jobs.map((job) {
              return ListTile(
                title: Text(job),
                onTap: () {
                  Navigator.of(context).pop(job);
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
