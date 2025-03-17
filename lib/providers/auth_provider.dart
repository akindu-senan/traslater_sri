import 'package:flutter/material.dart';
import 'package:traslater_sri/pages/bashboard/dashboard.dart';
import 'package:traslater_sri/pages/login/login_screen.dart';
import 'package:traslater_sri/pages/welcome_screen/welcome_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:traslater_sri/utils/secure_storage.dart';
import 'dart:developer' as dev;

import 'package:traslater_sri/widgets/common_popups.dart';

class AuthProvider extends ChangeNotifier {
  final storage = new FlutterSecureStorage();
  Future<void> checkAppVersion(context) async {
    Future.delayed(
      Duration(seconds: 2),
      () async {
        var freshInstaller = await storage.read(key: kFreshInstaller);
        var firstTimeLogin = await storage.read(key: kFirstTimeLogin);
        if (firstTimeLogin == "true") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
              (route) => false);
        } else if (firstTimeLogin == "false") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        } else {
          await storage.write(key: kFreshInstaller, value: 'true');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false);
        }
      },
    );
  }

  Future<void> firstTimeAppOpenProcess(context) async {
    try {
      await storage.write(key: kFreshInstaller, value: 'true');
      await storage.write(key: kFreshInstaller, value: 'true');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);

      dev.log(kFreshInstaller);
    } catch (e) {
      dev.log({e}.toString());
    }
  }

  //Login
  TextEditingController usernameController = TextEditingController();
  TextEditingController get getusernameController => usernameController;

  TextEditingController passwordController = TextEditingController();
  TextEditingController get getpasswordController => passwordController;
  //signin controllers
  TextEditingController signInusernameController = TextEditingController();
  TextEditingController get getsignInusernameController =>
      signInusernameController;

  TextEditingController emailController = TextEditingController();
  TextEditingController get getemailController => emailController;

  TextEditingController aboutMeController = TextEditingController();
  TextEditingController get getaboutMeController => aboutMeController;

  TextEditingController enterPasswordController = TextEditingController();
  TextEditingController get getenterPasswordController =>
      enterPasswordController;

  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController get getreEnterPasswordController =>
      reEnterPasswordController;

  //show password
  bool enterPassword = true;
  bool get getenterPassword => enterPassword;
  setenterPassword(val) {
    enterPassword = val;
    notifyListeners();
  }

  bool showConfPass = true;
  bool get getshowConfPass => showConfPass;
  setshowConfPass(val) {
    showConfPass = val;
    notifyListeners();
  }

  //create new user
  Future<void> clearRegistrationData(context) async {
    usernameController.clear();
    emailController.clear();
    reEnterPasswordController.clear();
    enterPasswordController.clear();
    setshowConfPass(true);
    setenterPassword(true);
  }

  Future<void> userRegistrationValidator(
    context,
  ) async {
    RegExp emailregex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    RegExp passwordregex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    // setloadCreateUserData(true);
    bool emailValidation = false;
    if (emailregex.hasMatch(emailController.text)) {
      emailValidation = true;
    } else {
      SnackbarHelper.showError(
        context: context,
        message: 'Invalide Email Address',
      );
      emailValidation = false;
    }

    bool passwordFormate = false;
    if (emailValidation) {
      if (passwordregex.hasMatch(enterPasswordController.text)) {
        passwordFormate = true;
      } else {
        SnackbarHelper.showError(
          context: context,
          message: 'Please enter strong password',
        );
        // commonMessage(context, message: "Please enter strong password").show();
        passwordFormate = false;
      }
    }

    if (passwordFormate) {
      if (enterPasswordController.text != getreEnterPasswordController.text) {
        // commonMessage(context, message: "Password mismatch").show();
        SnackbarHelper.showError(
          context: context,
          message: 'Password mismatch',
        );
      } else {
        setloadCreateUserData(true);
        // createNewUserAccounr(context, regType: regType);
      }
    }
  }

  bool loadCreateUserData = false;
  bool get getloadCreateUserData => loadCreateUserData;
  setloadCreateUserData(val) {
    loadCreateUserData = val;
    notifyListeners();
  }

  //login
  Future<void> loginFuntion(context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
      (route) => false,
    );
    await storage.write(key: kFirstTimeLogin, value: 'true');
  }

  //log Out
  Future<void> logOutFuntion(context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
    await storage.write(key: kFirstTimeLogin, value: 'false');
  }
}
