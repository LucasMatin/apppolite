import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(testapp());
}

class testapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Date Input Example')),
        body: DateTextField(),
      ),
    );
  }
}

class DateTextField extends StatefulWidget {
  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat =
      DateFormat('dd-MM-yyyy'); // รูปแบบวันที่ที่ต้องการ

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _dateController,
          decoration: InputDecoration(
            hintText: 'กรอกวันที่ (dd-mm-yyyy)',
          ),
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
            );

            if (selectedDate != null) {
              _dateController.text = _dateFormat.format(selectedDate);
            }
          },
          readOnly: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
