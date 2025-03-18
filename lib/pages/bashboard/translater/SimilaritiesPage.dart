import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  // Function to search text in public APIs
  Future<void> _searchOnline(String query) async {
    String googleBooksURL =
        "https://www.googleapis.com/books/v1/volumes?q=$query";
    String archiveURL =
        "https://archive.org/advancedsearch.php?q=$query&output=json";
    String openLibraryURL = "https://openlibrary.org/search.json?q=$query";
    String wikipediaURL =
        "https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=$query";

    List<String> results = [];

    try {
      final googleResponse = await http.get(Uri.parse(googleBooksURL));
      if (googleResponse.statusCode == 200) {
        final data = json.decode(googleResponse.body);
        results.addAll(data["items"]
                ?.map<String>((item) => item["volumeInfo"]["title"])
                ?.toList() ??
            []);
      }

      final archiveResponse = await http.get(Uri.parse(archiveURL));
      if (archiveResponse.statusCode == 200) {
        final data = json.decode(archiveResponse.body);
        results.addAll(data["response"]["docs"]
                ?.map<String>((item) => item["title"])
                ?.toList() ??
            []);
      }

      final openLibraryResponse = await http.get(Uri.parse(openLibraryURL));
      if (openLibraryResponse.statusCode == 200) {
        final data = json.decode(openLibraryResponse.body);
        results.addAll(
            data["docs"]?.map<String>((item) => item["title"])?.toList() ?? []);
      }

      final wikiResponse = await http.get(Uri.parse(wikipediaURL));
      if (wikiResponse.statusCode == 200) {
        final data = json.decode(wikiResponse.body);
        results.addAll(data["query"]["search"]
                ?.map<String>((item) => item["title"])
                ?.toList() ??
            []);
      }
    } catch (e) {
      print("Error searching: $e");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(results: results),
      ),
    );
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
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.blue),
                          onPressed: () =>
                              _searchOnline(_recentRecognitions[index]),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Search Results Page
class SearchResultsPage extends StatelessWidget {
  final List<String> results;

  SearchResultsPage({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results")),
      body: results.isEmpty
          ? Center(child: Text("No matching text found."))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(results[index]),
                    trailing: Icon(Icons.book),
                  ),
                );
              },
            ),
    );
  }
}

// Suggestion Detail Page
class SuggestionDetailPage extends StatelessWidget {
  final String title;

  SuggestionDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "Details about $title will be displayed here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
