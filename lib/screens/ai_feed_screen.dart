import 'package:flutter/material.dart';

class AiFeedScreen extends StatelessWidget {
  const AiFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMealCard(context),
          const SizedBox(height: 20),
          // Add more meal cards here
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement Snap to Log feature
        },
        label: const Text('Log Meal'),
        icon: const Icon(Icons.camera_alt),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMealCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Breakfast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildMealItem('Avocado', '40 g / 64 kcal'),
            _buildMealItem('Spinach', '30 g / 9 kcal'),
            _buildMealItem('Arugula', '15 g / 4 kcal'),
            _buildMealItem('Pomegranate', '15 g / 15 kcal'),
            _buildMealItem('Lentils', '50 g / 47 kcal'),
            const Divider(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Calories', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('139 kcal', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(String food, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(food, style: const TextStyle(fontSize: 16)),
          Text(details, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
