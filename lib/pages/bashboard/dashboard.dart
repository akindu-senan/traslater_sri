import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:traslater_sri/pages/bashboard/mapping_screen/mapping_screen.dart';
import 'package:traslater_sri/pages/bashboard/similar_words/similar_words.dart';
import 'package:traslater_sri/pages/bashboard/translater/translater.dart';
import 'package:traslater_sri/pages/login/login_screen.dart';
import 'package:traslater_sri/providers/auth_provider.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:traslater_sri/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:traslater_sri/widgets/common_dashboard_btn.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MainBody(
      // centerTitle: false,
      // appbar: true,
      appBarbackgroundColor: Colors.orange.shade200,
      automaticallyImplyLeading: true,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/drawer.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              accountEmail: const Text('testuser@email.com'),
              accountName: const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/drawer_profile.png',
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return Column(
                          children: [
                            CommonButton(
                              onPress: () {
                                authProvider.logOutFuntion(context);
                              },
                              buttonName: "Sign Out",
                              backgroundColor: kdefButtonCollor,
                              fontSize: 16,
                              textColor: kdefButtonTxtColor,
                            ),
                            const Text(
                              'Version 1.0.1',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
      appBarTitle: const Text("Traslater ශ්‍රී"),
      container: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background_cover_picture.jpg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10), // Adjust blur intensity
            child: Container(
              color: Colors.black
                  .withOpacity(0), // Transparent color overlay for interaction
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width * 2,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 7,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(color: Colors.white30),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(75),
                      topRight: Radius.circular(75),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonDashboardButton(
                              icon: const Icon(
                                FontAwesomeIcons.mapPin,
                                size: 45,
                                color: kDefTextColor,
                              ),
                              discription: "Mapping",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MappingScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonDashboardButton(
                              icon: const Icon(
                                FontAwesomeIcons.language,
                                size: 45,
                                color: kDefTextColor,
                              ),
                              discription: "Language and era",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonDashboardButton(
                              icon: const Icon(
                                FontAwesomeIcons.fileWord,
                                size: 45,
                                color: kDefTextColor,
                              ),
                              discription: "Similar words",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SimilarWord(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonDashboardButton(
                              icon: const Icon(
                                FontAwesomeIcons.globe,
                                size: 45,
                                color: kDefTextColor,
                              ),
                              discription: "Translate",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TranslaterScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                  // GridView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 2,
                  //       mainAxisSpacing: 2,
                  //       childAspectRatio: 0.7),
                  //   itemCount: 4,
                  //   itemBuilder: (context, index) {
                  //     return CommonDashboardButton();
                  //   },
                  // ),
                  // CommonDashboardButton(),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
