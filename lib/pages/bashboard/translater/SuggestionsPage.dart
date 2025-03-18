import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traslater_sri/pages/bashboard/translater/SimilaritiesPage.dart';

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

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = [
      "Similarities",
      "Unclear letters",
      "Era & Language",
      ""
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestions"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      suggestions[index],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                    onTap: () {
                      if (suggestions[index] == "Similarities") {
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
                                SuggestionDetailPage(title: suggestions[index]),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
