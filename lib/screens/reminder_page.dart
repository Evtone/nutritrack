import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  final List<String> mockReminders = [
    "08:00 AM – Breakfast",
    "12:30 PM – Lunch",
    "07:00 PM – Dinner",
    "10:00 PM – Drink Water",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders & Notifications")),
      body: ListView.builder(
        itemCount: mockReminders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.alarm),
            title: Text(mockReminders[index]),
            trailing: Icon(Icons.notifications_active, color: Colors.green),
          );
        },
      ),
    );
  }
}
