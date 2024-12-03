import 'package:demo/utils/type_def.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final ValidatorCallBack validator;

  const AuthTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: TextFormField(
        validator: validator,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.all(
            20,
          ),
        ),
      ),
    );
  }
}
