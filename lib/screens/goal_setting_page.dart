import 'package:flutter/material.dart';

class GoalSettingPage extends StatefulWidget {
  @override
  _GoalSettingPageState createState() => _GoalSettingPageState();
}

class _GoalSettingPageState extends State<GoalSettingPage> {
  final _weightGoalController = TextEditingController();
  final _calorieGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Your Goals')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _weightGoalController,
              decoration: InputDecoration(labelText: 'Target Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _calorieGoalController,
              decoration: InputDecoration(labelText: 'Daily Calorie Goal'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Goals Saved')),
                );
              },
              child: Text('Save Goals'),
            ),
          ],
        ),
      ),
    );
  }
}
