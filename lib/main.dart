// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unnecessary_string_interpolations, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nutritrack/screens/food_diary_screen.dart';
import 'package:nutritrack/screens/login_screen.dart';
import 'package:nutritrack/screens/registration_screen.dart';
import 'package:nutritrack/screens/main_screen.dart';
import 'package:nutritrack/screens/snap_to_log_screen.dart';
import 'package:nutritrack/screens/splash_screen.dart';
import 'package:nutritrack/services/auth_service.dart';
import 'package:nutritrack/screens/nutrition_dashboard_screen.dart';
import 'package:nutritrack/screens/profile_screen.dart';
import 'package:nutritrack/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NutriTrackApp());
}

class NutriTrackApp extends StatelessWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF4CAF50),
          secondary: Color(0xFFFF9800),
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF4CAF50)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF4CAF50),
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const MainScreen(),
        '/food': (context) => const FoodDiaryScreen(),
        '/snap-to-log': (context) => const SnapToLogScreen(),
        '/nutrition': (context) => const NutritionDashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}


