import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_config_plus/flutter_config_plus.dart';

class ApiService extends GetConnect {
  static String apiBaseUrl = FlutterConfigPlus.get('API_URL');

  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> data, String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders());

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> getData(String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final response = await http.get(Uri.parse(fullUrl), headers: setHeaders());

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> putData(
      Map<String, dynamic> data, String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final String? accessToken =
        await const FlutterSecureStorage().read(key: 'access_token');
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    print(jsonEncode(data));
    try {
      final response = await http.put(Uri.parse(fullUrl),
          body: jsonEncode(data), headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final responseBody = json.decode(response.body);
        throw Exception(
            'Status code: ${response.statusCode} Failed to put data to the API. Response: $responseBody');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to put data to the API');
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    var fullUrl = '$apiBaseUrl/user';
    final String? accessToken =
        await const FlutterSecureStorage().read(key: 'access_token');
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(Uri.parse(fullUrl), headers: headers);

    if (response.statusCode == 200) {
      print("Get user data success");
      final responseData = json.decode(response.body);
      final userData = responseData['user'];
      return json.decode(userData);
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to get data from the API');
    }
  }

  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
