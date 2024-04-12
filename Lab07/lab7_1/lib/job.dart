import 'package:flutter/material.dart';

class RadioListTileExample extends StatefulWidget {
  final Function(String) onSelected;
  final String initialJob;

  const RadioListTileExample({
    Key? key,
    required this.onSelected,
    required this.initialJob,
  }) : super(key: key);

  @override
  State<RadioListTileExample> createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  late String _selectedJob;
  List<String> jobs = ["Engineer", "Doctor", "Teacher", "Artist", "Other"];

  @override
  void initState() {
    super.initState();
    _selectedJob = widget.initialJob;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: jobs.map((String job) {
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
