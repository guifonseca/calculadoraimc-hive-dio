import 'package:flutter/material.dart';

class ListTileField extends StatelessWidget {
  final String title;
  final String value;

  const ListTileField({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(title),
      const SizedBox(
        width: 5,
      ),
      Text(value)
    ]);
  }
}
