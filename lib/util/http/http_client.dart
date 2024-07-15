import 'dart:convert';

import 'package:http/http.dart' as http;


class NHttpHlper {
  static const String _baseUrl = 'https://api-base.com';

  // helper function to make a GET request
  static Future<Map<String, dynamic>> get(String endPoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }

  //helper function to make POST request
  static Future<Map<String, dynamic>> post(
      String endPoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {'content-Type': 'application/jason'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //helper function to make a PUT request
  static Future<Map<String, dynamic>> put(String endPoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {'content-Type': 'application/jason'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  //Helper fn to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endPoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'));
    return _handleResponse(response);
  }


  //Helper fn to handle the HTTP response
static Map<String, dynamic> _handleResponse(http.Response response) {
    if(response.statusCode==200){
      return json.decode(response.body);

    } else{
      throw Exception('Failed to load data:  ${response.statusCode}') ;
    }
}
}
