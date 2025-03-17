import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:traslater_sri/providers/auth_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, value, child) {
          return Stack(
            children: [
              Swiper.children(
                autoplay: true,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.grey.shade700,
                        activeColor: Colors.blue.shade800,
                        size: 10.0,
                        activeSize: 12.0)),
                children: <Widget>[
                  Image.asset(
                    'assets/images/welcome_image1.png',
                    fit: BoxFit.contain,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/welcome_image2.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/welcome_image3.jpeg',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 1.1,
                    left: 10,
                    right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              authProvider.firstTimeAppOpenProcess(context);
                            });
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Skip",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Icon(
                                Icons.navigate_next_outlined,
                                size: 35,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
