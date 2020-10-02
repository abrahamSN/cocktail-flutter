import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FOLLOW GAMES YOU LOVE!",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            letterSpacing: -2.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
