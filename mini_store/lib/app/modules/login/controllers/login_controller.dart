import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mini_store/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var submitClicked = false.obs;

  // Local Authentication
  final LocalAuthentication _localAuth = LocalAuthentication();
  var isBiometricAvailable = false.obs;
  var isAuthenticating = false.obs;

  String? validateEmail(email) {
    if (email.length == 0) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    final valid = emailRegex.hasMatch(email);
    if (valid) {
      return null;
    }
    return 'Email is Invalid';
  }

  String? validatePassword(password) {
    bool valid = password.length > 0;
    if (valid) {
      return null;
    }
    return 'Password is required';
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        "130010460553-cftrflh6d6qcb243a6a1m5q4p7f32km0.apps.googleusercontent.com",
    scopes: ['email', 'profile'],
  );

  Future<void> handleGoogleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final account = await _googleSignIn.signIn();

      if (account == null) {
        print("User canceled Google sign-in");
        return;
      }

      final auth = await account.authentication;

      final idToken = auth.idToken;

      print("idToken: $idToken");
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> handleFacebookSignIn() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        print("accessToken: $accessToken");
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
  }

  @override
  void onInit() {
    super.onInit();
    _checkBiometricAvailability();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // Check if biometric authentication is available
  Future<void> _checkBiometricAvailability() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();

      isBiometricAvailable.value = isAvailable && isDeviceSupported;

      if (isBiometricAvailable.value) {
        final List<BiometricType> availableBiometrics =
            await _localAuth.getAvailableBiometrics();
        print('Available biometrics: $availableBiometrics');
      }
    } catch (e) {
      print('Error checking biometric availability: $e');
      isBiometricAvailable.value = false;
    }
  }

  // Perform biometric authentication
  Future<void> authenticateWithBiometrics() async {
    if (!isBiometricAvailable.value) {
      Get.snackbar(
        'Error',
        'Biometric authentication is not available on this device',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isAuthenticating.value = true;

      final bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to login to Mini Store',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // Navigate to home or perform login logic
        Get.toNamed(Routes.HOME);
      }
    } catch (e) {
      print('Biometric authentication error: $e');
      Get.snackbar(
        'Error',
        'Biometric authentication failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isAuthenticating.value = false;
    }
  }
}
