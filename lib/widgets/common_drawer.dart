import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traslater_sri/providers/auth_provider.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/widgets/common_button.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail:
                const Text('testuser@email.com'), // Later, fetch dynamically
            accountName: const Text(
              "Welcome",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/drawer_profile.png'),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Column(
                  children: [
                    CommonButton(
                      onPress: () {
                        authProvider
                            .logOutFunction(context); // Corrected this line
                      },
                      buttonName: "Sign Out",
                      backgroundColor: kdefButtonCollor,
                      textColor: kdefButtonTxtColor,
                    ),
                    const SizedBox(height: 8),
                    const Text('Version 1.0.1',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
