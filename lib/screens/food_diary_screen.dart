// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FoodDiaryScreen extends StatelessWidget {
  const FoodDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Food Log',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildFoodLogItem('Breakfast', 'Oatmeal with berries', '420 cal', Icons.breakfast_dining),
                  _buildFoodLogItem('Lunch', 'Grilled chicken salad', '580 cal', Icons.lunch_dining),
                  _buildFoodLogItem('Snack', 'Protein shake', '220 cal', Icons.local_cafe),
                  _buildFoodLogItem('Dinner', 'Salmon with veggies', '630 cal', Icons.dinner_dining),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quick Add',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _buildQuickAddChip('Apple', '95 cal'),
                _buildQuickAddChip('Banana', '105 cal'),
                _buildQuickAddChip('Chicken Breast', '165 cal'),
                _buildQuickAddChip('Salad', '80 cal'),
                _buildQuickAddChip('Protein Bar', '200 cal'),
                _buildQuickAddChip('Yogurt', '150 cal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodLogItem(String meal, String food, String calories, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF4CAF50)),
        ),
        title: Text(meal, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(food),
        trailing: Text(calories, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildQuickAddChip(String food, String calories) {
    return Chip(
      backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
      label: Text('$food ($calories)'),
      avatar: const Icon(Icons.add, size: 18, color: Color(0xFF4CAF50)),
    );
  }
}
