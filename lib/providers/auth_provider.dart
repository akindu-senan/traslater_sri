import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:traslater_sri/pages/bashboard/dashboard.dart';
import 'package:traslater_sri/pages/login/login_screen.dart';
import 'package:traslater_sri/pages/welcome_screen/welcome_screen.dart';
import 'package:traslater_sri/utils/secure_storage.dart';
import 'package:traslater_sri/widgets/common_popups.dart';
import 'dart:developer' as dev;

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  get getpasswordController => null;

  get getenterPassword => null;

  get getshowConfPass => null;

  get getloadCreateUserData => null;

  /// Checks app version and navigates accordingly
  Future<void> checkAppVersion(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));

    final firstTimeLogin = await storage.read(key: kFirstTimeLogin);

    if (firstTimeLogin == "true") {
      navigateToScreen(context, const Dashboard());
    } else if (firstTimeLogin == "false") {
      navigateToScreen(context, const LoginScreen());
    } else {
      await storage.write(key: kFreshInstaller, value: 'true');
      navigateToScreen(context, const WelcomeScreen());
    }
  }

  /// First-time app open process
  Future<void> firstTimeAppOpenProcess(BuildContext context) async {
    try {
      await storage.write(key: kFreshInstaller, value: 'true');
      navigateToScreen(context, const LoginScreen());
      dev.log(kFreshInstaller);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  /// Navigates to a given screen and removes all previous routes
  void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  // Controllers for Login & Registration
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController signInUsernameController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController enterPasswordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();

  /// Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    signInUsernameController.dispose();
    emailController.dispose();
    aboutMeController.dispose();
    enterPasswordController.dispose();
    reEnterPasswordController.dispose();
    super.dispose();
  }

  // Password Visibility Toggle
  bool enterPassword = true;
  bool showConfPass = true;

  void setEnterPassword(bool val) {
    enterPassword = val;
    notifyListeners();
  }

  void setShowConfPass(bool val) {
    showConfPass = val;
    notifyListeners();
  }

  /// Clears user registration data
  void clearRegistrationData(BuildContext context) {
    usernameController.clear();
    emailController.clear();
    reEnterPasswordController.clear();
    enterPasswordController.clear();
    setShowConfPass(true);
    setEnterPassword(true);
  }

  /// Validates user registration input
  Future<void> userRegistrationValidator(BuildContext context) async {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$');

    if (!emailRegex.hasMatch(emailController.text)) {
      SnackbarHelper.showError(
          context: context, message: 'Invalid Email Address');
      return;
    }

    if (!passwordRegex.hasMatch(enterPasswordController.text)) {
      SnackbarHelper.showError(
          context: context, message: 'Please enter a strong password');
      return;
    }

    if (enterPasswordController.text != reEnterPasswordController.text) {
      SnackbarHelper.showError(context: context, message: 'Password mismatch');
      return;
    }

    setLoadCreateUserData(true);
    // Call create user account logic here...
  }

  // Loading state for user creation
  bool loadCreateUserData = false;

  void setLoadCreateUserData(bool val) {
    loadCreateUserData = val;
    notifyListeners();
  }

  /// Handles user login
  Future<void> loginFunction(BuildContext context) async {
    navigateToScreen(context, const Dashboard());
    await storage.write(key: kFirstTimeLogin, value: 'true');
  }

  /// Handles user logout
  Future<void> logOutFunction(BuildContext context) async {
    navigateToScreen(context, const LoginScreen());
    await storage.write(key: kFirstTimeLogin, value: 'false');
  }
}
