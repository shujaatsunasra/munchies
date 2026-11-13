import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  AuthRepository({http.Client? client}) : _client = client ?? http.Client();

  static const _baseUrl = 'https://shoply-kj50.onrender.com/api/auth';
  final http.Client _client;

  Future<String?> login({
    required String identifier,
    required String password,
  }) {
    return _post('/login', {'identifier': identifier, 'password': password});
  }

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String gender,
  }) {
    return _post('/register', {
      'name': name,
      'email': email,
      'password': password,
      'mobile': mobile,
      'gender': gender,
    });
  }

  Future<String?> _post(String path, Map<String, String> body) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl$path'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) return null;
      try {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['message'] ?? data['error'] ?? 'Something went wrong.')
            .toString();
      } catch (_) {
        return 'Request failed (${response.statusCode}).';
      }
    } catch (_) {
      return 'Unable to connect. Check your internet connection and try again.';
    }
  }
}
