import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taghyeer_assessment/features/auth/model/auth_model.dart';

class AuthRepo {
  static const _userKey = 'cached_user';
  static const _loginUrl = 'https://dummyjson.com/auth/login';

  Future<AuthModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      final user = AuthModel.fromJson(jsonDecode(response.body));
      await _saveUser(user);
      return user;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Login failed');
    }
  }

  Future<void> _saveUser(AuthModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<AuthModel?> getCachedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_userKey);
    if (data == null) return null;
    return AuthModel.fromJson(jsonDecode(data));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}