import 'package:flutter/material.dart';

class Boolwidget extends StatefulWidget {
  final  String textLabel;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<bool> onChanged;
  const Boolwidget({super.key, required this.textLabel, required this.hintText, required this.controller, required this.onChanged});

  @override
  State<Boolwidget> createState() => _BoolwidgetState();
}

class _BoolwidgetState extends State<Boolwidget> {
  bool? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),

      Text(widget.textLabel,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10,
      ),

      DropdownButton<bool>(
        value: selectedValue,
        hint: Text(widget.hintText),
        items: [
        // Option for 'Yes' (true)
        DropdownMenuItem<bool>(
          value: true,
          child: Text('Yes'),
        ),
        // Option for 'No' (false)
        DropdownMenuItem<bool>(
          value: false,
          child: Text('No'),
        ),
      ], onChanged: (bool? newValue) {
        setState(() {
          selectedValue = newValue; // Update the selected value
        });
        widget.onChanged(newValue!); // Call the parent callback with the new value
      },
      ),
    ],
    );
  }
}

