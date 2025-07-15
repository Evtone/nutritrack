// ignore_for_file: unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;

class FitnessHomeScreen extends StatelessWidget {
  const FitnessHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/snap-to-log');
        },
        label: const Text('Snap to Log'),
        icon: const Icon(Icons.camera_alt),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDateSelector(),
              const SizedBox(height: 20),
              _buildCalorieDashboard(),
              const SizedBox(height: 20),
              _buildMealGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Friday 1 November',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.grey),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCalorieDashboard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Light green background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const _InfoColumn(value: '331', label: 'Left'),
              _buildCalorieCircle(),
              const _InfoColumn(value: '267', label: 'Burn'),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MacroInfo(label: 'Carbs', value: '78/100g'),
              _MacroInfo(label: 'Proteins', value: '23/75g'),
              _MacroInfo(label: 'Fat', value: '31/46g'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieCircle() {
    return const SizedBox(
      width: 120,
      height: 120,
      child: Center(
        child: Text(
          '1769',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50)),
        ),
      ),
    );
  }

  Widget _buildMealGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _MealCard(icon: Icons.coffee, label: 'Breakfast', calories: '540', color: Colors.brown[300]!),
        _MealCard(icon: Icons.lunch_dining, label: 'Lunch', calories: '601', color: Colors.orange[300]!),
        _MealCard(icon: Icons.dinner_dining, label: 'Dinner', calories: '628', color: Colors.red[300]!),
        _AddMealCard(),
      ],
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String value;
  final String label;
  const _InfoColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}

class _MacroInfo extends StatelessWidget {
  final String label;
  final String value;
  const _MacroInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}

class _MealCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String calories;
  final Color color;

  const _MealCard({
    required this.icon,
    required this.label,
    required this.calories,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('$calories kcal', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _AddMealCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
      ),
      child: const Center(
        child: Icon(Icons.add, size: 50, color: Color(0xFF4CAF50)),
      ),
    );
  }
}
