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

  @override
  void initState() {
    super.initState();
    _recentRecognitions = List.from(widget.recentRecognitions);
  }

  // Function to delete an item and update SharedPreferences
  Future<void> _deleteItem(int index) async {
    setState(() {
      _recentRecognitions.removeAt(index);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentRecognitions', _recentRecognitions);
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
                    title: Text(
                      _recentRecognitions[index],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
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
