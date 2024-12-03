import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String description;
  const AuthHeader({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "./assets/images/logo.png",
          height: 80,
        ),
         Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
