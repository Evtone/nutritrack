// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nutritrack/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  late User? _currentUser;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
          
      if (doc.exists) {
        if (mounted) {
          setState(() {
            _userData = doc.data() as Map<String, dynamic>;
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.local_dining, color: Color(0xFF4CAF50)),
            const SizedBox(width: 10),
            const Text('NutriTrack'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF4CAF50),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _userData?['name'] ?? 'User',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _userData?['email'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            }),
            _buildDrawerItem(Icons.fastfood, 'Food Diary', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/food');
            }),
            _buildDrawerItem(Icons.bar_chart, 'Nutrition Dashboard', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/nutrition');
            }),
            _buildDrawerItem(Icons.person, 'Profile', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            }),
            const Divider(),
            _buildDrawerItem(Icons.settings, 'Settings', () {}),
            _buildDrawerItem(Icons.help, 'Help Center', () {}),
            _buildDrawerItem(Icons.logout, 'Logout', () {
              _authService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${_userData?['name'] ?? 'User'}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('EEEE, MMMM d').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildNutritionCard('Calories', '1,850', 
                      _userData?['dailyCalories']?.toString() ?? '2000', 
                      85, const Color(0xFFFF9800)),
                  const SizedBox(width: 15),
                  _buildNutritionCard('Protein', '125g', 
                      '${_userData?['dailyProtein'] ?? 140}g', 
                      90, const Color(0xFF4CAF50)),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildNutritionCard('Carbs', '210g', 
                      '${_userData?['dailyCarbs'] ?? 250}g', 
                      85, const Color(0xFF2196F3)),
                  const SizedBox(width: 15),
                  _buildNutritionCard('Fat', '62g', 
                      '${_userData?['dailyFat'] ?? 70}g', 
                      88, const Color(0xFF9C27B0)),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Meals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/food'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildMealItem('Breakfast', 'Oatmeal with berries', '420 cal', Icons.breakfast_dining),
              _buildMealItem('Lunch', 'Grilled chicken salad', '580 cal', Icons.lunch_dining),
              _buildMealItem('Snack', 'Protein shake', '220 cal', Icons.local_cafe),
              _buildMealItem('Dinner', 'Salmon with veggies', '630 cal', Icons.dinner_dining),
              const SizedBox(height: 25),
              const Text(
                'Health Tips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildHealthTip(
                'Drink more water',
                'Aim for 8 glasses per day to boost metabolism',
                Icons.local_drink
              ),
              _buildHealthTip(
                'Get enough protein',
                'Protein helps maintain muscle mass during weight loss',
                Icons.fitness_center
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/food'),
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4CAF50)),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildNutritionCard(String title, String value, String goal, int percent, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '$percent% of $goal',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: color.withOpacity(0.3),
              color: color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealItem(String time, String meal, String calories, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  meal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            calories,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF9800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTip(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 28),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
