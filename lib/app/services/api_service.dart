import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetConnect {
  static const String apiBaseUrl = 'http://192.168.2.44/api'; // Laravel API URL
  // static const String apiBaseUrl = 'http://10.31.105.196/api'; // Laravel API URL

  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> data, String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final responseBody = json.decode(response.body);
      throw Exception(
          'Status code: ${response.statusCode} Failed to post data to the API. Response: $responseBody');
    }
  }

  Future<Map<String, dynamic>> getData(String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final response = await http.get(Uri.parse(fullUrl), headers: _setHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to get data from the API');
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    var fullUrl = '$apiBaseUrl/user';
    final String? accessToken =
        await const FlutterSecureStorage().read(key: 'access_token');
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer $accessToken', // Include the token in the headers
    };
    final response = await http.get(Uri.parse(fullUrl), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to get data from the API');
    }
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
