import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "https://eviweb.ir";
  final String consumerKey = "ck_placeholder";
  final String consumerSecret = "cs_placeholder";

  Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/wp-json/jwt-auth/v1/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        return token;
      }
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }

  Future<List<dynamic>> fetchOrders() async {
    String auth = base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/wp-json/wc/v3/orders'),
        headers: {'Authorization': 'Basic $auth'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Fetch Orders Error: $e');
    }
    return [];
  }
}
