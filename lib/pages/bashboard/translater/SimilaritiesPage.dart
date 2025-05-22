import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:traslater_sri/model/historic_term.dart';

class SimilaritiesPage extends StatefulWidget {
  final List<String> recentRecognitions;

  SimilaritiesPage({required this.recentRecognitions});

  @override
  _SimilaritiesPageState createState() => _SimilaritiesPageState();
}

class _SimilaritiesPageState extends State<SimilaritiesPage> {
  late List<String> _recentRecognitions;
  late Set<String> duplicateWords;
  List<HistoricTerm> _historicTerms = [];

  @override
  void initState() {
    super.initState();
    _recentRecognitions = List.from(widget.recentRecognitions);
    _loadHistoricTerms();
    duplicateWords = _findDuplicateWords(_recentRecognitions);
  }

  Future<void> _loadHistoricTerms() async {
    final String jsonString =
        await rootBundle.loadString('assets/historic_terms.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    setState(() {
      _historicTerms =
          jsonList.map((item) => HistoricTerm.fromJson(item)).toList();
    });
  }

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

  Future<void> _deleteItem(int index) async {
    setState(() {
      _recentRecognitions.removeAt(index);
      duplicateWords = _findDuplicateWords(_recentRecognitions);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentRecognitions', _recentRecognitions);
  }

  Widget _highlightDuplicatesAndMap(String text) {
    List<TextSpan> spans = [];

    for (var word in text.split(" ")) {
      final isDuplicate = duplicateWords.contains(word);
      final match = _historicTerms.firstWhere(
        (term) => term.term == word,
        orElse: () => HistoricTerm(term: '', era: '', meaning: ''),
      );

      spans.add(
        TextSpan(
          text: "$word ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isDuplicate ? FontWeight.bold : FontWeight.normal,
            color: match.term.isNotEmpty
                ? Colors.blue
                : (isDuplicate ? Colors.red : Colors.black),
          ),
        ),
      );

      if (match.term.isNotEmpty) {
        spans.add(
          TextSpan(
            text: "(${match.era}: ${match.meaning}) ",
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
          children: spans, style: const TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Similarities")),
      body: _recentRecognitions.isEmpty
          ? const Center(child: Text("No similarities found"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _recentRecognitions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title:
                        _highlightDuplicatesAndMap(_recentRecognitions[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteItem(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
