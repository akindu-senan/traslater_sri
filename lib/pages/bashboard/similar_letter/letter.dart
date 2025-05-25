import 'package:flutter/material.dart';

class LetterPage extends StatelessWidget {
  final List<String> unclearLetters;

  const LetterPage(
      {Key? key,
      required this.unclearLetters,
      required List recognizedCharacters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> freqMap = {};
    for (var letter in unclearLetters) {
      freqMap[letter] = (freqMap[letter] ?? 0) + 1;
    }

    final sortedLetters = freqMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text("Unclear Letters"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sortedLetters.length,
        itemBuilder: (context, index) {
          final entry = sortedLetters[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(entry.key)),
              title: Text("Character: ${entry.key}"),
              subtitle: Text("Detected ${entry.value} time(s)"),
            ),
          );
        },
      ),
    );
  }
}
