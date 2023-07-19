import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback buttonFuncion;
  final IconData iconSymbol;
  const CustomIconButton(
      {super.key, required this.buttonFuncion, required this.iconSymbol});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonFuncion,
      icon: Icon(
        iconSymbol,
        color: Theme.of(context).primaryColor,
        size: 35,
      ),
    );
  }
}
