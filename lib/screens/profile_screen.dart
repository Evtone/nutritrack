import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  User? _user;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  File? _profileImageFile;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    try {
      final doc = await _firestore.collection('users').doc(_user!.uid).get();
      if (mounted) {
        setState(() {
          _userData = doc.data();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user data: $e')),
        );
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    setState(() {
      _profileImageFile = imageFile;
    });

    try {
      final ref = _storage.ref().child('profile_pictures').child('${_user!.uid}.jpg');
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();

      await _firestore.collection('users').doc(_user!.uid).update({'profilePictureUrl': url});

      if (mounted) {
        setState(() {
          _userData?['profilePictureUrl'] = url;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  ImageProvider<Object> _getProfileImage() {
    if (_profileImageFile != null) {
      return FileImage(_profileImageFile!);
    }
    if (_userData?['profilePictureUrl'] != null && _userData!['profilePictureUrl'].isNotEmpty) {
      return NetworkImage(_userData!['profilePictureUrl']);
    }
    return const AssetImage('assets/images/profile.jpg'); // Placeholder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileBody(),
    );
  }

  Widget _buildProfileBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(),
          const SizedBox(height: 20),
          _buildUserInfo(),
          const SizedBox(height: 30),
          _buildGoalsCard(),
          const SizedBox(height: 30),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _getProfileImage(),
          backgroundColor: Colors.grey.shade200,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickAndUploadImage,
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF4CAF50),
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          _userData?['name'] ?? 'User Name',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          _userData?['email'] ?? 'user@example.com',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildGoalsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutrition Goals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Daily Calories', _userData?['dailyCalories']?.toString() ?? 'N/A'),
            const Divider(),
            _buildInfoRow('Protein', '${_userData?['dailyProtein']?.toString() ?? 'N/A'} g'),
            const Divider(),
            _buildInfoRow('Carbs', '${_userData?['dailyCarbs']?.toString() ?? 'N/A'} g'),
            const Divider(),
            _buildInfoRow('Fat', '${_userData?['dailyFat']?.toString() ?? 'N/A'} g'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _auth.signOut();
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text('Logout', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
