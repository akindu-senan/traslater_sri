import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traslater_sri/providers/auth_provider.dart';
import 'package:traslater_sri/utils/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(context, listen: false)
          .checkAppVersion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefBackgrounColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image
              const Image(
                image: AssetImage("assets/images/splash_image.png"),
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 20), // Adjust spacing dynamically

              // App Title
              const Text(
                "Translator ශ්‍රී",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
