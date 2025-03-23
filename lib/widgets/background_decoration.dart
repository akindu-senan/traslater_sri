import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  const BackgroundDecoration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_cover_picture.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Blur Effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.2), // Slight overlay
          ),
        ),
        // Foreground Content
        child,
      ],
    );
  }
}
