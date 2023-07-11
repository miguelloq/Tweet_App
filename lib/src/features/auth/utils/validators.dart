import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compareString({
    required String input,
    required String message,
  }) {
    return (v) {
      if (v.toString() != input) {
        return message;
      }
      return null;
    };
  }
}
