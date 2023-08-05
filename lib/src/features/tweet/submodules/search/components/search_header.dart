import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final Function(String)? onChangeTextFunction;
  const SearchHeader({super.key, required this.onChangeTextFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Search a user',
          style: TextStyle(fontSize: 32),
        ),
        const SizedBox(
          height: 25,
        ),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: onChangeTextFunction,
        ),
      ],
    );
  }
}
