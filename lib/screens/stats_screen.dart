// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Stats'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDailyIntakeCard(),
            const SizedBox(height: 20),
            _buildWeightLossCard(),
            const SizedBox(height: 20),
            _buildWeekNutritionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyIntakeCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daily Intake', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const LinearProgressIndicator(
              value: 0.8,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1714 kcal left'),
                Text('1808 kcal goal'),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MacroCircle(label: 'Proteins', amount: '68 g', goal: '94 g', color: Colors.blue),
                _MacroCircle(label: 'Fats', amount: '52 g', goal: '62 g', color: Colors.orange),
                _MacroCircle(label: 'Carbs', amount: '212 g', goal: '225 g', color: Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightLossCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Losing Weight', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('80 kg'),
                Text('4.5 kg left'),
                Text('75 kg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekNutritionCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Week Nutrition', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                  .map((day) => Text(day, style: const TextStyle(fontWeight: FontWeight.bold)))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _NutritionBar(day: 'Su', value: 0.8, color: Colors.green[300]!),
                _NutritionBar(day: 'Mo', value: 0.9, color: Colors.green),
                _NutritionBar(day: 'Tu', value: 0.85, color: Colors.green),
                _NutritionBar(day: 'We', value: 0.95, color: Colors.green),
                _NutritionBar(day: 'Th', value: 0.7, color: Colors.green[300]!),
                _NutritionBar(day: 'Fr', value: 0.4, color: Colors.grey[300]!),
                _NutritionBar(day: 'Sa', value: 0.3, color: Colors.grey[300]!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroCircle extends StatelessWidget {
  final String label;
  final String amount;
  final String goal;
  final Color color;

  const _MacroCircle({
    required this.label,
    required this.amount,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            value: 0.75, // static for now
            strokeWidth: 8,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('$amount / $goal'),
      ],
    );
  }
}

class _NutritionBar extends StatelessWidget {
  final String day;
  final double value;
  final Color color;

  const _NutritionBar({
    required this.day,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100 * value,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 5),
        // Text(day), // Day label is now at the top
      ],
    );
  }
}
