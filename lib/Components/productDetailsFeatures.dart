import 'package:flutter/material.dart';

class FeaturesBox extends StatelessWidget {
  final String label;
  final String desc;
  const FeaturesBox({super.key, required this.label, required this.desc,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
          style: TextStyle(
              color: Colors.grey[255],
              fontSize: 15
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(desc,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
        ),
      ],
    );
  }
}
