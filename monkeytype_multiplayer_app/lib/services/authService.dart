import 'dart:convert';

import 'package:http/http.dart' as http;

class Authservice {
  final String BASE_URL = "http://localhost:5000/api";

  Future<bool> registerUser(
    String username,
    String email,
    String password,
  ) async {
    print("hllo");
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
}
