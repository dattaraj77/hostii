import 'dart:async';

import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages

class ApiProvider extends ChangeNotifier {
  // Mock base URL and HTTP client
  final String baseUrl;
  // final http.Client httpClient; // Commented out as it's not needed for frontend-only

  ApiProvider({
    required this.baseUrl,
    // required this.httpClient, // Commented out as it's not needed for frontend-only
  });

  // Mock method to simulate a GET request
  Future<void> getRequest(String endpoint) async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock response
    print("GET request to $baseUrl$endpoint - Mock response");
  }

  // Mock method to simulate a POST request
  Future<void> postRequest(String endpoint,
      {Map<String, dynamic>? body}) async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock response
    print("POST request to $baseUrl$endpoint with body $body - Mock response");
  }

  // Mock method to simulate a PUT request
  Future<void> putRequest(String endpoint, {Map<String, dynamic>? body}) async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock response
    print("PUT request to $baseUrl$endpoint with body $body - Mock response");
  }

  // Mock method to simulate a DELETE request
  Future<void> deleteRequest(String endpoint) async {
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));
    // Mock response
    print("DELETE request to $baseUrl$endpoint - Mock response");
  }
}
