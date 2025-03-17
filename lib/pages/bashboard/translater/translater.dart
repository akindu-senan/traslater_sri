import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traslater_sri/providers/translater_provider.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:provider/provider.dart';
import 'package:traslater_sri/widgets/common_button.dart';
import 'package:traslater_sri/widgets/common_popups.dart';
import 'package:traslater_sri/widgets/common_textfeild.dart';

class TranslaterScreen extends StatefulWidget {
  const TranslaterScreen({super.key});

  @override
  State<TranslaterScreen> createState() => _TranslaterScreenState();
}

class _TranslaterScreenState extends State<TranslaterScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TranslaterProvider>(context, listen: false).clearImageModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      appBarTitle: const Text("Translate"),
      automaticallyImplyLeading: true,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: kdefButtonCollor,
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => Container(
              child: Card(
                color: Colors.white,
                child: SizedBox(
                  height: 120,
                  child: Consumer<TranslaterProvider>(
                    builder: (context, translaterProvider, child) {
                      return Column(
                        children: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              translaterProvider.pickImage(
                                context,
                                ImageSource.camera,
                              );
                            },
                            child: const Text('Camera'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              translaterProvider.pickImage(
                                context,
                                ImageSource.gallery,
                              );
                            },
                            child: const Text('Gallery'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          FontAwesomeIcons.camera,
          size: 45,
          color: kdefButtonTxtColor,
        ),
      ),
      container: SingleChildScrollView(
        child: Consumer<TranslaterProvider>(
          builder: (context, translaterProvider, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (translaterProvider.imagePath != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (translaterProvider.imagePath != null)
                              Text(
                                "Selected Image",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (translaterProvider.imagePath != null)
                              Image.file(
                                File(
                                  translaterProvider.imagePath.toString(),
                                ),
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                            if (translaterProvider.imagePath != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CommonButton(
                                    onPress: () {
                                      // if (translaterProvider.imagePath !=
                                      //     null) {
                                      translaterProvider.getImageToText(
                                        imagePath: translaterProvider.imagePath
                                            .toString(),
                                      );
                                      print("object");
                                      // } else {
                                      //   SnackbarHelper.showError(
                                      //       context: context,
                                      //       message: "message");
                                      // }
                                    },
                                    buttonName: "scanner",
                                    backgroundColor: kdefButtonCollor,
                                    fontSize: 14,
                                    textColor: kdefButtonTxtColor,
                                  )
                                ],
                              )
                          ],
                        ),
                    ],
                  ),
                ),
                if (translaterProvider.imagePath != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.black,
                          height: 10,
                        ),
                      ),
                      Text(
                        "Result",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ///text box ScrollView
                      translaterProvider.getloadingTranslatortxt
                          ? const CircularProgressIndicator()
                          : Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${translaterProvider.extractedText}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
