import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traslater_sri/model/image_model.dart';
import 'dart:developer' as dev;
// import 'package:get/get.dart';

class TranslaterProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  String? get getimagePath => imagePath;
  setimagePath(val) {
    imagePath = val;
    notifyListeners();
  }

  Future<void> pickImage(
    context,
    ImageSource source, {
    ImageUploadModel? imageModel,
  }) async {
    XFile? file = await _picker.pickImage(source: source);
    dev.log(file!.path);
    ImageUploadModel(imageUrlPath: file.path.toString());
    setimagePath(
      file.path.toString(),
    );
    // setimageUplodeModelData(imagePath: tmp.path);
    notifyListeners();
  }

  //Pick images
  ImageUploadModel? imageUplodeModelData;
  ImageUploadModel? get getimageUplodeModelDataa => imageUplodeModelData;
  setimageUplodeModelData(val, {required ImageUploadModel imagePath}) {
    imageUplodeModelData = val;
    notifyListeners();
  }

  // Future<void> recognizedText(BuildContext context,
  //     {String? pickedImage}) async {
  //   if (pickedImage == null) {
  //     if (context.mounted) {
  //       SnackbarHelper.showError(
  //         context: context,
  //         message: "Image is not selected",
  //       );
  //     }
  //     return;
  //   }

  //   extractedText = '';
  //   //   var textRecognizer = GoogleMlKit.vision.textRecognizer();
  //   //   final visionImage = InputImage.fromFilePath(pickedImage);

  //   //   try {
  //   //     var visionText = await textRecognizer.processImage(visionImage);
  //   //     StringBuffer extractedTextBuffer = StringBuffer();
  //   //     for (TextBlock textBlock in visionText.blocks) {
  //   //       for (TextLine textLine in textBlock.lines) {
  //   //         for (TextElement textElement in textLine.elements) {
  //   //           extractedTextBuffer.write('${textElement.text} ');
  //   //         }
  //   //         extractedTextBuffer.writeln();
  //   //       }
  //   //     }
  //   //     extractedText = extractedTextBuffer.toString();
  //   //   } catch (e) {
  //   //     if (context.mounted) {
  //   //       SnackbarHelper.showError(
  //   //         context: context,
  //   //         message: "Error: $e",
  //   //       );
  //   //     }
  //   //   } finally {
  //   //     textRecognizer.close();
  //   //   }
  // }
  String? extractedText = '';
  String? get getextractedText => extractedText;
  setextractedText(val) {
    extractedText = val;
    notifyListeners();
  }

  Future<String?> getImageToText({required String imagePath}) async {
    try {
      setloadingTranslatortxt(true);
      // Initialize the text recognizer with the specified script.
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);

      // Process the image to extract text.
      final RecognizedText recognizedText =
          await textRecognizer.processImage(InputImage.fromFilePath(imagePath));

      // Extract the text and update the state.
      final String text = recognizedText.text;
      setextractedText(text);
      dev.log("resul translate $text");
      // Dispose of the text recognizer when done to free resources.
      textRecognizer.close();

      return text;
    } catch (e) {
      // Handle errors gracefully, log, or display a message if needed.
      dev.log('Error in getImageToText: $e');
      setloadingTranslatortxt(false);
      return null;
    } finally {
      setloadingTranslatortxt(false);
    }
  }

  bool loadingTranslatortxt = false;
  bool get getloadingTranslatortxt => loadingTranslatortxt;
  setloadingTranslatortxt(val) {
    loadingTranslatortxt = val;
    notifyListeners();
  }

  clearImageModel() async {
    setimagePath(null);
    setextractedText('');
    ImageUploadModel(imageUrlPath: []);
  }
}
