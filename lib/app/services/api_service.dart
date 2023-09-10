import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:school_bus/models/api_response.dart';

class ApiService extends GetConnect {
  // static const String apiBaseUrl = 
      // 'http://192.168.2.44/api'; // Laravel API KURL
  // static const String apiBaseUrl = 'http://10.31.105.196/api'; // Laravel API KURL2
  static const String apiBaseUrl = 'http://192.168.1.114/api'; // Laravel API URL [TAM]

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
      return json.decode(response.body);
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to get data from the API');
    }
  }

  Future<ApiResponse> updateUser(String? image) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final String? token =
        await const FlutterSecureStorage().read(key: 'access_token');
      final response = await http.post(
        Uri.parse('http://192.168.1.114/api/register'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }, 
        body: image == null ? null : jsonEncode({'image': image}));

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


  String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
