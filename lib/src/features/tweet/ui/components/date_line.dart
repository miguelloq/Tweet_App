import 'package:flutter/material.dart';

class DateLine extends StatelessWidget {
  final DateTime date;
  final double fontSize;
  const DateLine({super.key, required this.date, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${date.hour}:${date.minute} · ${date.month}/${date.day}/${date.year} ·',
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    );
  }
}
