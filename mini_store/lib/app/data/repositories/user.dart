import 'package:mini_store/app/core/alert.dart';
import 'package:mini_store/app/core/loading.dart';
import 'package:mini_store/app/data/constants.dart';
import 'package:mini_store/app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository with LoadingDialog, AlertDialogs {
  Future<User?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      showLoading();

      final response = await http.get(
        Uri.parse("$baseUrl/users/$id"),
        headers: {'Authorization': 'Bearer $token'},
      );
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return User.fromJson(data);
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

  Future<bool> checkEmailExists(String email) async {
    try {
      showLoading();
      final response = await http.get(
        Uri.parse('$baseUrl/users/check-email-taken?email=$email'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return false;
      } else {
        final data = jsonDecode(response.body);
        showAlert(title: 'Error', middleText: data['message']);
        return true;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }

  Future<bool> updateName(String name) async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$id/name'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'fullName': name},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('fullName', name);
        return true;
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return false;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }

  Future<bool> updateStoreName(String name) async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$id/store'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'storeName': name},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('storeName', name);
        return true;
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return false;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }

  Future<bool> updateAddress(String latitude, String longitude) async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$id/address'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'latitude': latitude, 'longitude': longitude},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return false;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$id/password'),
        headers: {'Authorization': 'Bearer $token'},
        body: {'oldPassword': oldPassword, 'newPassword': newPassword},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return false;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }

  Future<bool> deleteAccount(String? password) async {
    try {
      showLoading();
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      final id = prefs.getString('id');
      final response = await http.delete(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Authorization': 'Bearer $token'},
        body: password != null ? {'password': password} : null,
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.clear();
        return true;
      } else {
        showAlert(title: 'Error', middleText: data['message']);
        return false;
      }
    } catch (e) {
      showAlert(title: 'Error', middleText: e.toString());
      return false;
    } finally {
      closeLoading();
    }
  }
}
