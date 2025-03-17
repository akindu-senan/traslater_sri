import 'package:flutter/material.dart';
import 'package:traslater_sri/providers/auth_provider.dart';
import 'package:traslater_sri/utils/colors.dart';
import 'package:traslater_sri/utils/main_body.dart';
import 'package:provider/provider.dart';
import 'package:traslater_sri/widgets/common_button.dart';
import 'package:traslater_sri/widgets/common_textfeild.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false)
          .clearRegistrationData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      appBarTitle: const Text("Sign In"),
      automaticallyImplyLeading: true,
      container: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Image(
                          width: 100,
                          height: 100,
                          image: AssetImage("assets/images/sign_up.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextFeild(
                              controller: authProvider.signInusernameController,
                              label: "Name",
                              hint: "Name",
                              fullborder: true,
                              isValidate: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextFeild(
                              label: "Email",
                              hint: "Email",
                              fullborder: true,
                              isValidate: true,
                              controller: authProvider.emailController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextFeild(
                              label: "Password",
                              hint: "Password",
                              isPassword:
                                  authProvider.getenterPassword ? true : false,
                              isValidate: true,
                              fullborder: true,
                              controller: authProvider.enterPasswordController,
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // profileProvider.getshowConfPass ==
                                      //     !profileProvider.getshowConfPass;
                                      authProvider.setenterPassword(
                                          !authProvider.getenterPassword);
                                    });
                                  },
                                  icon: authProvider.getenterPassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonTextFeild(
                              label: "Conformed Password",
                              hint: "Conformed Password",
                              controller:
                                  authProvider.reEnterPasswordController,
                              isPassword:
                                  authProvider.getshowConfPass ? true : false,
                              fullborder: true,
                              isValidate: true,
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // profileProvider.getshowConfPass ==
                                      //     !profileProvider.getshowConfPass;
                                      authProvider.setshowConfPass(
                                          !authProvider.getshowConfPass);
                                    });
                                  },
                                  icon: authProvider.getshowConfPass
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                            ),
                          ),
                          authProvider.getloadCreateUserData
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CommonButton(
                                      backgroundColor: kdefButtonCollor,
                                      onPress: () {
                                        if (formKey.currentState!.validate()) {
                                          authProvider
                                              .userRegistrationValidator(
                                                  context);
                                        }
                                      },
                                      textColor: kdefButtonTxtColor,
                                      buttonName: "Sing Up",
                                    ),
                                  ))
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
