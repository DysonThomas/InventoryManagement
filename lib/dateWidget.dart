import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  final  String textLabel;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<DateTime> onChanged;
  const DateWidget({super.key, required this.textLabel, required this.hintText, required this.controller, required this.onChanged});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    widget.onChanged(selectedDate);
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(
          height: 10,
        ),

        Text(widget.textLabel,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: widget.controller,
          readOnly: true, // Prevent manual entry
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context), // Show date picker on tap
            ),
          ),
        ),
      ],
      ),
    );
  }
}
