import 'package:flutter/material.dart';
import 'package:traslater_sri/pages/sign_up/sing_up_screen.dart';
import 'package:traslater_sri/providers/auth_provider.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/utils/main_body.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:traslater_sri/widgets/common_button.dart';
import 'package:traslater_sri/widgets/common_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MainBody(
          appbar: true,
          automaticallyImplyLeading: true,
          container: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                child: Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage(
                        "assets/images/Profile.png",
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: kDefTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          color: kDefTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: CommonTextFeild(
                      label: "User name",
                      hint: "User name",
                      isValidate: true,
                      controller: authProvider.usernameController,
                      fullborder: true,
                      suffix: const Icon(Icons.person),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 12,
                      right: 12,
                    ),
                    child: CommonTextFeild(
                      suffix: const Icon(Icons.lock),
                      label: "Password",
                      hint: "Password",
                      isValidate: true,
                      controller: authProvider.getpasswordController,
                      fullborder: true,
                      isPassword: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 12,
                      right: 12,
                    ),
                    child: Column(
                      children: [
                        // loginProvider.getloadLoginData
                        //     ? const CommonLoader()
                        //     :
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CommonButton(
                            backgroundColor: kdefButtonCollor,
                            textColor: kdefButtonTxtColor,
                            fontSize: 18,
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                authProvider.loginFunction(context);
                              }
                            },
                            buttonName: "Login",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Divider(
                          color: Colors.red,
                          thickness: 2,
                        ),
                      ),
                      const Text(
                        " or ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Divider(
                          color: Colors.red,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 15,
                          right: 12,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kDefTextColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const SingUpScreen();
                                  },
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const SingUpScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
