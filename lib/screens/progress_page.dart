import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  final double weightProgress = 0.6; // 60% to goal
  final double calorieProgress = 0.4; // 40% of daily goal

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Weight Progress", style: TextStyle(fontSize: 18)),
            LinearProgressIndicator(value: weightProgress),
            SizedBox(height: 20),
            Text("Calorie Progress", style: TextStyle(fontSize: 18)),
            LinearProgressIndicator(value: calorieProgress),
            SizedBox(height: 40),
            Text("Keep going! You're doing great! 💪"),
          ],
        ),
      ),
    );
  }
}
