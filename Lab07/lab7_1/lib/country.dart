import 'package:flutter/material.dart';

List<String> countriesList = [
  // ASEAN countries
  'Brunei',
  'Cambodia',
  'Indonesia',
  'Laos',
  'Malaysia',
  'Myanmar',
  'Philippines',
  'Singapore',
  'Thailand',
  'Vietnam',
  // EU countries
  'Austria',
  'Belgium',
  'Bulgaria',
  'Croatia',
  'Republic of Cyprus',
  'Czech Republic',
  'Denmark',
  'Estonia',
  'Finland',
  'France',
  'Germany',
  'Greece',
  'Hungary',
  'Ireland',
  'Italy',
  'Latvia',
  'Lithuania',
  'Luxembourg',
  'Malta',
  'Netherlands',
  'Poland',
  'Portugal',
  'Romania',
  'Slovakia',
  'Slovenia',
  'Spain',
  'Sweden',
];

Future<void> selectTime(BuildContext context, TimeOfDay initialTime, void Function(TimeOfDay) callback) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  if (picked != null && picked != initialTime) {
    callback(picked);
  }
}

Future<void> selectDate(BuildContext context, DateTime initialDate, void Function(DateTime) callback) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != initialDate) {
    callback(picked);
  }
}
