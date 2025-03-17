import 'package:flutter/material.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:traslater_sri/widgets/common_mapping_card.dart';

class MappingScreen extends StatefulWidget {
  const MappingScreen({super.key});

  @override
  State<MappingScreen> createState() => _MappingScreenState();
}

class _MappingScreenState extends State<MappingScreen> {
  @override
  Widget build(BuildContext context) {
    return const MainBody(
      automaticallyImplyLeading: true,
      appBarTitle: Text("Mapping"),
      container: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonMappingCard(
              imageUrl: "assets/images/splash_image.png",
              eraTxt: "මහනුවර යුගයේ",
              period: "ක්‍රි. ව. 1473 සිට 1815",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonMappingCard(
              imageUrl: "assets/images/palum_book_2.jpg",
              eraTxt: "පෙලොන්නරු යුගය",
              period: "ක්‍රි.පූ 1017",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonMappingCard(
              imageUrl: "assets/images/background_coverimage.png",
              eraTxt: "අනුරාධපුර යුගය",
              period: "ක්‍රි.පූ 900 - 600",
            ),
          )
        ],
      )),
    );
  }
}
