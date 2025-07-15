import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
