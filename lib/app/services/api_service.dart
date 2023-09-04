import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetConnect {
  static const String apiBaseUrl = 'http://192.168.2.44/api'; // Laravel API URL

  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> data, String apiUrl) async {
    final fullUrl = apiBaseUrl + apiUrl;
    final response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data to the API');
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

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
