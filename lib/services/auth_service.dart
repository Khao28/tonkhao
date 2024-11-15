import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? ''; // Load from .env file
  final storage = FlutterSecureStorage();

  // Check if the token is expired
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token); // Returns true if the token is expired
  }

  // Extract role from the token
  String extractRoleFromToken(String token) {
    try {
      // Decode the JWT token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Extract role from the decoded token (adjust the key as needed)
      String role = decodedToken['role'] ?? 'Unknown'; // Default to 'Unknown' if role is missing

      return role;
    } catch (e) {
      print("Error decoding token: $e");
      return 'Unknown';
    }
  }

  // Register User
  Future<bool> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Successfully registered
    } else {
      print('Registration failed: ${response.body}');
      return false;
    }
  }

  // Login User
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String token = responseData['token'];
      
      // Extract role from the JWT token
      String role = extractRoleFromToken(token);
      print(role);

      // Store token in secure storage
      await storage.write(key: 'auth_token', value: token);
      
      return {'role': role, 'token': token};
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  }

  // Logout User
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }

  // Get Token
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  // Validate Token Expiration
  Future<bool> validateTokenExpiration() async {
    String? token = await getToken();
    if (token == null) {
      return false; // No token available
    }
    return !isTokenExpired(token); // Returns true if token is valid (not expired)
  }
}
