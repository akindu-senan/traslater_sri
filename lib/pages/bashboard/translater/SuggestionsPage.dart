import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:traslater_sri/pages/bashboard/translater/SimilaritiesPage.dart';
import 'package:traslater_sri/widgets/common_dashboard_btn.dart';

class SuggestionsPage extends StatefulWidget {
  final String recognizedText;

  SuggestionsPage({required this.recognizedText});

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  List<String> recentRecognitions = [];

  @override
  void initState() {
    super.initState();
    loadRecentRecognitions();
  }

  Future<void> loadRecentRecognitions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentRecognitions = prefs.getStringList('recentRecognitions') ?? [];
    });
  }

  final List<Map<String, dynamic>> suggestions = [
    {"title": "Similarities", "icon": FontAwesomeIcons.link},
    {"title": "Unclear letters", "icon": FontAwesomeIcons.questionCircle},
    {"title": "Era & Language", "icon": FontAwesomeIcons.book},
    {"title": "Other", "icon": FontAwesomeIcons.ellipsisH},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions"),
        backgroundColor: const Color.fromARGB(255, 243, 180, 33),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_cover_picture.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: suggestions.map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CommonDashboardButton(
                    icon: Icon(
                      item['icon'],
                      size: 45,
                      color: Colors.white,
                    ),
                    discription: item['title'],
                    onTap: () {
                      if (item['title'] == "Similarities") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SimilaritiesPage(
                                recentRecognitions: recentRecognitions),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Placeholder(), // Replace with actual page
                          ),
                        );
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
