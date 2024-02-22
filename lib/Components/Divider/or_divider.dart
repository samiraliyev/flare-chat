import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
            height: 0.8,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'or',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey,
            height: 0.8,
          ),
        ),
      ],
    );
  }
}
