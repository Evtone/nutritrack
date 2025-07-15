// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _checkAuthStatus);
  }

  void _checkAuthStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (mounted) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Icon(
                Icons.fastfood, // Changed from nutrition for better visuals
                size: 100,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'NutriTrack',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Track your nutrition, transform your health',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
