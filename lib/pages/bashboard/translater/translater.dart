import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traslater_sri/pages/bashboard/translater/SuggestionsPage.dart';

class TranslaterScreen extends StatefulWidget {
  const TranslaterScreen({super.key});

  @override
  State<TranslaterScreen> createState() => _TranslaterScreenState();
}

class _TranslaterScreenState extends State<TranslaterScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  String v = "";
  List<String> recentRecognitions = [];

  @override
  void initState() {
    super.initState();
    loadRecentRecognitions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        _image = image;
        file = File(image.path);
      });
      detectImage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions.toString();
      saveRecentRecognition(v);
    });
  }

  Future<void> saveRecentRecognition(String text) async {
    final prefs = await SharedPreferences.getInstance();
    recentRecognitions.insert(0, text);
    if (recentRecognitions.length > 5) {
      recentRecognitions = recentRecognitions.sublist(0, 5);
    }
    prefs.setStringList('recentRecognitions', recentRecognitions);
  }

  Future<void> loadRecentRecognitions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentRecognitions = prefs.getStringList('recentRecognitions') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Image'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 223, 53),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (_image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(_image!.path),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Text('No image selected', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image from Gallery'),
                ),
                SizedBox(height: 20),
                if (v.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      v,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                if (v.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuggestionsPage(
                            recognizedText: v,
                          ),
                        ),
                      );
                    },
                    child: Text('Go to Suggestions'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
