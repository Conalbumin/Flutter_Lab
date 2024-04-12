import 'package:flutter/material.dart';


class RadioListTileExample extends StatefulWidget {
  final Function(String) onSelected;

  const RadioListTileExample({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<RadioListTileExample> createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  List<String> jobs = ["Engineer", "Doctor", "Teacher", "Artist", "Other"];

  String _selectedJob = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: jobs.map((job) {
          return RadioListTile<String>(
            title: Text(job),
            value: job,
            groupValue: _selectedJob,
            onChanged: (String? value) {
              setState(() {
                _selectedJob = value!;
              });
              widget.onSelected(value!);
            },
          );
        }).toList(),
      ),
    );
  }
}
