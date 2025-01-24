import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  final String label;
  final Color clr;
  final Function onPressed;
  const ActionButtons({super.key, required this.label, required this.clr, required this.onPressed});

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.clr // Blue color
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Text(widget.label ,style: TextStyle(
        color: Colors.white, // White text
        fontWeight: FontWeight.bold, // Bold text
        fontSize: 16, // Adjust font size
      ),),
    );
  }
}
