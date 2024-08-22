import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://api.friends-in.com/api';

  Future<Map<String, dynamic>> getFriends() async {
    final response = await http.get(Uri.parse('$baseUrl/v1/friends'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load friends');
    }
  }

  Future<String> login() async {
    final url = Uri.parse('$baseUrl/v1/login');
    final headers = {
      "Content-Type": "application/json",
    };
    final body = json.encode({
      "username": "aimie@friends-in.com",
      "password": "password",
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 302) {
        final location = response.headers['location'];
        if (location != null) {
          final redirectedResponse = await http.get(Uri.parse(location));
          return redirectedResponse.body;
        } else {
          throw Exception('Redirection location is null');
        }
      } else if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<Map<String, dynamic>> getChats() async {
    final response = await http.get(Uri.parse('$baseUrl/chats'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chats');
    }
  }
}
