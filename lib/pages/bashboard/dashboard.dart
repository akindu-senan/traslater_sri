import 'dart:ui';
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
      appBarTitle: const Text("Traslater ශ්‍රී"),
      container: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_cover_picture.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur effect for background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Optimized blur
            child: Container(color: Colors.black.withOpacity(0.1)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 2,
              width: screenWidth * 0.9, // Optimized width
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
                  padding: const EdgeInsets.all(8.0),
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
