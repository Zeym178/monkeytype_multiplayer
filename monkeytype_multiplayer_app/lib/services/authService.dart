import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authservice {
  final String BASE_URL = "http://localhost:5000/api";
  final String _tokenKey = "tokenKeyLol";

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? islogged = prefs.getString(_tokenKey);

    if (islogged != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);

    if (token == null) {
      print("there's no token :o");
      return null;
    }

    final response = await http.get(
      Uri.parse("$BASE_URL/users/current"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("User data fetched successfully");
      return data['user'];
    } else {
      return null;
    }
  }

  Future<bool> registerUser(
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$BASE_URL/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(response.body);
      print("the token is: ${data['token']}");
      prefs.setString(_tokenKey, data['token']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
    String? token = prefs.getString(_tokenKey);
    if (token == null) {
      return true;
    } else {
      return false;
    }
  }
}
