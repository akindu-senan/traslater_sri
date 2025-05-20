import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:traslater_sri/providers/auth_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> imagePaths = [
    'assets/images/welcome_image1.png',
    'assets/images/plm (1).jpg',
    'assets/images/plm (2).jpg',
    'assets/images/plm (3).jpg',
    'assets/images/plm (4).jpg',
    'assets/images/plm (5).jpg',
    'assets/images/plm (6).jpg',
    'assets/images/welcome_image2.jpeg',
    'assets/images/welcome_image3.jpeg',
  ];

  final List<Color> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final TextStyle colorizeTextStyle = const TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            children: [
              // Swiper background
              Swiper(
                autoplay: true,
                duration: 2000,
                loop: true,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey.shade700,
                    activeColor: Colors.blue.shade800,
                    size: 8.0,
                    activeSize: 12.0,
                  ),
                ),
                itemCount: imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),

              // Blur overlay for focus
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),

              // Magical animated text
              Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Welcome to Translator ශ්‍රී',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: false,
                  totalRepeatCount: 1,
                ),
              ),

              // Skip button
              Positioned(
                bottom: 30,
                right: 20,
                child: InkWell(
                  onTap: () {
                    authProvider.firstTimeAppOpenProcess(context);
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
