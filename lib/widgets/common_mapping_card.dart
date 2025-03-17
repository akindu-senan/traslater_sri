import 'package:flutter/material.dart';

class CommonMappingCard extends StatelessWidget {
  const CommonMappingCard({
    super.key,
    required this.imageUrl,
    required this.eraTxt,
    required this.period,
  });
  final String imageUrl;
  final String eraTxt;
  final String period;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Image(
                image: AssetImage(imageUrl
                    // "assets/images/splash_image.png",
                    ),
                height: 100,
                width: 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$eraTxt"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$period"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
