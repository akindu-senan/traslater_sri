import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimilaritiesPage extends StatefulWidget {
  final List<String> recentRecognitions;

  SimilaritiesPage({required this.recentRecognitions});

  @override
  _SimilaritiesPageState createState() => _SimilaritiesPageState();
}

class _SimilaritiesPageState extends State<SimilaritiesPage> {
  late List<String> _recentRecognitions;
  late Set<String> duplicateWords;

  @override
  void initState() {
    super.initState();
    _recentRecognitions = List.from(widget.recentRecognitions);
    duplicateWords = _findDuplicateWords(_recentRecognitions);
  }

  // Function to find duplicate words
  Set<String> _findDuplicateWords(List<String> items) {
    Map<String, int> wordCount = {};
    Set<String> duplicates = {};

    for (var item in items) {
      for (var word in item.split(" ")) {
        wordCount[word] = (wordCount[word] ?? 0) + 1;
        if (wordCount[word]! > 1) {
          duplicates.add(word);
        }
      }
    }
    return duplicates;
  }

  // Function to delete an item and update SharedPreferences
  Future<void> _deleteItem(int index) async {
    setState(() {
      _recentRecognitions.removeAt(index);
      duplicateWords = _findDuplicateWords(_recentRecognitions);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentRecognitions', _recentRecognitions);
  }

  // Function to highlight duplicate words
  Widget _highlightDuplicates(String text) {
    List<TextSpan> spans = [];
    for (var word in text.split(" ")) {
      spans.add(
        TextSpan(
          text: "$word ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: duplicateWords.contains(word)
                ? FontWeight.bold
                : FontWeight.normal,
            color: duplicateWords.contains(word) ? Colors.red : Colors.black,
          ),
        ),
      );
    }
    return RichText(
        text: TextSpan(children: spans, style: TextStyle(color: Colors.black)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Similarities")),
      body: _recentRecognitions.isEmpty
          ? Center(child: Text("No similarities found"))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _recentRecognitions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: _highlightDuplicates(_recentRecognitions[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteItem(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
