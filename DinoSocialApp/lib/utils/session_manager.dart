import 'dart:io';

class SessionManager {
  static String? token;
  static String? userId;
  static String? username;
  static String? avatarUrl;

  static String get host {
    return Platform.isAndroid ? '10.0.2.2' : 'localhost';
  }

  static String get baseUrl => 'http://$host:8080/api';

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'accept': '*/*',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static void clear() {
    token = null;
    userId = null;
    username = null;
    avatarUrl = null;
  }
}
