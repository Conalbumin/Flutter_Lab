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

Future<DateTime?> selectDate(BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  // Extract only the date part
  if (picked != null) {
    return DateTime(picked.year, picked.month, picked.day);
  }
  return null; // Return null if the user cancels the picker
}

Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay initialTime) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  return picked ?? initialTime;
}
