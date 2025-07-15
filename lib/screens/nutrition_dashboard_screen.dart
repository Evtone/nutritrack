import 'package:flutter/material.dart';

class NutritionDashboardScreen extends StatelessWidget {
  const NutritionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Nutrition Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Calories Consumed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNutritionBar('Mon', 1800, 2000, const Color(0xFF4CAF50)),
                        _buildNutritionBar('Tue', 2100, 2000, const Color(0xFF4CAF50)),
                        _buildNutritionBar('Wed', 1950, 2000, const Color(0xFF4CAF50)),
                        _buildNutritionBar('Thu', 2200, 2000, const Color(0xFF4CAF50)),
                        _buildNutritionBar('Fri', 1700, 2000, const Color(0xFF4CAF50)),
                        _buildNutritionBar('Sat', 2300, 2000, const Color(0xFFFF9800)),
                        _buildNutritionBar('Sun', 1600, 2000, const Color(0xFFFF9800)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Macronutrient Distribution',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildMacroCard('Protein', '140g', '30%', const Color(0xFF4CAF50)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildMacroCard('Carbs', '250g', '50%', const Color(0xFFFF9800)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildMacroCard('Fat', '70g', '20%', const Color(0xFFF44336)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Daily Goals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildGoalItem('Water Intake', '6/8 glasses', 75),
            _buildGoalItem('Fruits & Vegetables', '4/5 servings', 80),
            _buildGoalItem('Exercise', '30/60 minutes', 50),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionBar(String day, int value, int max, Color color) {
    double percentage = value / max;
    return Column(
      children: [
        Container(
          width: 30,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 30,
              height: 150 * percentage,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(day),
        Text('$value'),
      ],
    );
  }

  Widget _buildMacroCard(String name, String value, String percentage, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(String goal, String progress, int percentage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  goal,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  progress,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF4CAF50),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}
