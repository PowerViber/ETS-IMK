import 'package:flutter/material.dart';

class MemorizationScreen extends StatelessWidget {
  const MemorizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            Text(
              'Memorization Screen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
