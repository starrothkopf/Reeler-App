import 'package:flutter/material.dart';

class StyledFormField extends StatelessWidget {
  final FormField child;
  const StyledFormField({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
  const Color dark2 = Color(0xFF292929); // dark
    return Container(
      decoration: BoxDecoration(
        color: dark2,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
        child: child,
      ),
    );
  }
}
