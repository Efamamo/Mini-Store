import 'package:http/http.dart' as http;
import 'package:mini_store/app/core/alert.dart';
import 'package:mini_store/app/core/loading.dart';
import 'package:mini_store/app/data/constants.dart';
import 'package:mini_store/app/data/models/auth_response.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository with LoadingDialog, AlertDialogs {
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      showLoading();
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signin'),
        body: {'email': email, 'password': password},
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> signUp(
    String email,
    String password,
    String fullName,
    String? storeName,
    String? latitude,
    String? longitude,
  ) async {
    try {
      showLoading();

      final body = <String, dynamic>{
        'email': email,
        'password': password,
        'fullName': fullName,
      };

      if (storeName != null) {
        body['address'] = {
          'latitude': latitude,
          'longitude': longitude,
          'storeName': storeName,
        };
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print(response.body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> signUpWithGoogle(
    String idToken,
    String? storeName,
    String? latitude,
    String? longitude,
  ) async {
    try {
      showLoading();

      final body = <String, dynamic>{'idToken': idToken, 'fromProvider': true};

      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> signUpWithFacebook(
    String idToken,
    String? storeName,
    String? latitude,
    String? longitude,
  ) async {
    try {
      showLoading();
      final body = <String, dynamic>{'idToken': idToken, 'fromProvider': true};

      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup/facebook'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> refreshToken(String token) async {
    try {
      showLoading();

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        body: {'refreshToken': token},
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(
          title: 'Error',
          middleText: "For security reasons, please login again",
        );
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> signInWithGoogle(String idToken) async {
    try {
      showLoading();
      final body = {'idToken': idToken};

      final response = await http.post(
        Uri.parse('$baseUrl/auth/signin/google'),
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<AuthResponse?> signInWithFacebook(String idToken) async {
    try {
      showLoading();
      final body = {'idToken': idToken};

      final response = await http.post(
        Uri.parse('$baseUrl/auth/signin/facebook'),
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AuthResponse.fromJson(data);
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return null;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return null;
    } finally {
      closeLoading();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('fullName');
    prefs.remove('id');
    prefs.remove('email');
  }
}
