import 'package:dio/dio.dart';
import 'package:flutter_auth_bloc_dio/core/internet_services/path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    final token = await _secureStorage.read(key: 'token');
    return token != null;
  }

  Future<void> persisToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'token');
  }

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      loginUrl,
      data: {
        'username': username,
        'password': password,
      },
    );
    return response.data['token'] as String;
  }
}
