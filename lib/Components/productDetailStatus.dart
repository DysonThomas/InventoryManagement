import 'package:flutter/material.dart';


class StatusBar extends StatelessWidget {
  final Color color;
  final String status;

  const StatusBar({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle, // Bullet point icon
          size: 12, // Size of the bullet point
          color: color, // Bullet point color
        ),
        Text(
          status,
          style: TextStyle(
            fontSize: 40, // Large font size
            fontWeight: FontWeight.bold, // Bold text
            color: color, // Red color
            letterSpacing: 2, // Spacing between letters
            shadows: [
              Shadow(
                offset: Offset(2, 2), // Shadow position
                blurRadius: 5, // Shadow blur radius
                color: Colors.black.withOpacity(0.5), // Shadow color with opacity
              ),
            ],
          ),
        ),
      ],
    );
  }
}
