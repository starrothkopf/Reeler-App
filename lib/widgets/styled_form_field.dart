import 'package:flutter/material.dart';

class StyledFormField extends StatelessWidget {
  final FormField child;
  const StyledFormField({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 217, 181),
        border: Border.all(
          color:const Color.fromARGB(255, 246, 167, 110),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
        child: child,
      ),
    );
  }
}
