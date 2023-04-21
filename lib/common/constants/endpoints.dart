
abstract class Endpoints {
  static String apiUrl = '/api';

  static String authme = '$apiUrl/v1/auth/me';
  static String login = '$apiUrl/auth/login';
  static String refershToken = '$apiUrl/auth/refresh-token';
}
