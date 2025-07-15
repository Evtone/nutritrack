import 'package:flutter/material.dart';

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int currentGlasses = 0;
  final int dailyGoal = 8;

  void addGlass() {
    if (currentGlasses < dailyGoal) {
      setState(() {
        currentGlasses++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentGlasses / dailyGoal;

    return Scaffold(
      appBar: AppBar(title: Text('Water Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Water Intake', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('$currentGlasses / $dailyGoal glasses'),
            SizedBox(height: 20),
            LinearProgressIndicator(value: progress),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: addGlass,
              child: Text('Add Glass'),
            ),
          ],
        ),
      ),
    );
  }
}
