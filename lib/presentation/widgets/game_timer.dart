import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final int counter;

  const GameTimer({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black38,
        shape: BoxShape.circle,
        border: Border.all(width: 3, color: const Color(0xC65C0000)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          '$counter',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
