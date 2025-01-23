import 'package:flutter/material.dart';



class InputFieldss extends StatefulWidget {
  final  String textLabel;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const InputFieldss({super.key, required this.textLabel, required this.hintText, required this.controller, required this.onChanged});

  @override
  State<InputFieldss> createState() => _InputFieldssState();
}

class _InputFieldssState extends State<InputFieldss> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ), Text(widget.textLabel,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
          onChanged: widget.onChanged,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
