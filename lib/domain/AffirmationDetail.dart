import 'package:flutter/material.dart';
import '../domain/affirmation.dart';

class AffirmationDetail extends StatelessWidget {
  final Affirmation affirmation;

  const AffirmationDetail({required this.affirmation, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Détails de l'affirmation")),
      body: Column(
        children: [
          Image.asset(
            affirmation.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              affirmation.desc,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
