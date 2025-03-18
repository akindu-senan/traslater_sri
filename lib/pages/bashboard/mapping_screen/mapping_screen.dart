import 'package:flutter/material.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:traslater_sri/widgets/common_mapping_card.dart';

class MappingScreen extends StatefulWidget {
  const MappingScreen({super.key});

  @override
  State<MappingScreen> createState() => _MappingScreenState();
}

class _MappingScreenState extends State<MappingScreen> {
  List<Map<String, String>> mappings = [
    {
      "imageUrl": "assets/images/splash_image.png",
      "eraTxt": "මහනුවර යුගයේ",
      "period": "ක්‍රි. ව. 1473 සිට 1815"
    },
    {
      "imageUrl": "assets/images/palum_book_2.jpg",
      "eraTxt": "පෙලොන්නරු යුගය",
      "period": "ක්‍රි.පූ 1017"
    },
    {
      "imageUrl": "assets/images/background_coverimage.png",
      "eraTxt": "අනුරාධපුර යුගය",
      "period": "ක්‍රි.පූ 900 - 600"
    }
  ];

  void _editMapping(int index) {
    TextEditingController eraController =
        TextEditingController(text: mappings[index]["eraTxt"]);
    TextEditingController periodController =
        TextEditingController(text: mappings[index]["period"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Mapping"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: eraController,
              decoration: InputDecoration(labelText: "Era"),
            ),
            TextField(
              controller: periodController,
              decoration: InputDecoration(labelText: "Period"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                mappings[index]["eraTxt"] = eraController.text;
                mappings[index]["period"] = periodController.text;
              });
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteMapping(int index) {
    setState(() {
      mappings.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      automaticallyImplyLeading: true,
      appBarTitle: Text("Mapping"),
      container: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: mappings.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                CommonMappingCard(
                  imageUrl: mappings[index]["imageUrl"]!,
                  eraTxt: mappings[index]["eraTxt"]!,
                  period: mappings[index]["period"]!,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editMapping(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteMapping(index),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
