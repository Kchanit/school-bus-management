import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService {
  final storage = FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }

  Future<String?> getRole() async {
    return await storage.read(key: 'role');
  }

  Future<String?> getId() async {
    return await storage.read(key: 'id');
  }

  Future<void> setToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  Future<void> setRole(String role) async {
    await storage.write(key: 'role', value: role);
  }

  Future<void> setId(String id) async {
    await storage.write(key: 'id', value: id);
  }

  Future<void> removeToken() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'role');
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> logout() async {
    await removeToken();
    Get.offAllNamed('/login');
  }
}
