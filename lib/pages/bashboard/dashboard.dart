import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:traslater_sri/pages/bashboard/translater/translater.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:traslater_sri/widgets/common_dashboard_btn.dart';
import 'package:traslater_sri/widgets/common_drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MainBody(
      appBarbackgroundColor: Colors.orange.shade200,
      automaticallyImplyLeading: true,
      drawer: const CommonDrawer(),
      appBarTitle: const Text("Translator ශ්‍රී"),
      container: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_cover_picture.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Blur overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Center animated text
          Stack(
            children: [
              // Background and blur effects here...

              // Positioned animated text at the top
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.08, // Adjust as needed
                left: 20,
                right: 20,
                child: Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          "Welcome To\nTranslator ශ්‍රී",
                          duration: const Duration(seconds: 4),
                        ),
                        FadeAnimatedText(
                          "Get Start",
                          duration: const Duration(seconds: 2),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      pause: const Duration(seconds: 1),
                      displayFullTextOnTap: true,
                    ),
                  ),
                ),
              ),

              // Other widgets (like your bottom container) go here...
            ],
          ),

          // Bottom panel with Translate button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 2.3,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.black38,
                border: Border.all(color: Colors.white30),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75),
                  topRight: Radius.circular(75),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonDashboardButton(
                    icon: const Icon(
                      FontAwesomeIcons.globe,
                      size: 45,
                      color: kDefTextColor,
                    ),
                    discription: "Translate",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TranslaterScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
