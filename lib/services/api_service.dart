import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';
  final String tableName = 'form_data';

  Future<List<MessageModel>> getMessages() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$tableName'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => MessageModel.fromJson(item)).toList();
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response body: ${response.body}');
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during API call: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<MessageModel> createMessage(MessageModel message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$tableName'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(message.toJson()),
      );

      print('Create response status: ${response.statusCode}');
      print('Create response body: ${response.body}');

      if (response.statusCode == 201) {
        // Handle empty or malformed response
        if (response.body.isEmpty) {
          // If the server doesn't return the created object, return the original with a dummy ID
          return MessageModel(
            id: -1, // Temporary ID
            name: message.name,
            email: message.email,
            message: message.message,
            createdAt: DateTime.now(),
          );
        }
        
        try {
          // Try to parse the response
          final jsonData = jsonDecode(response.body);
          if (jsonData is List && jsonData.isNotEmpty) {
            return MessageModel.fromJson(jsonData[0]);
          } else if (jsonData is Map) {
            return MessageModel.fromJson(jsonData.cast<String, dynamic>());
          } else {
            // Return the original message if we can't parse the response
            return message;
          }
        } catch (e) {
          print('Error parsing response: $e');
          // Return the original message if we can't parse the response
          return message;
        }
      } else {
        throw Exception('Failed to create message: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during create: $e');
      throw Exception('Network error during create: $e');
    }
  }

  Future<MessageModel> getUserByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$tableName?email=eq.$email'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        if (body.isNotEmpty) {
          return MessageModel.fromJson(body[0]);
        } else {
          throw Exception('User not found');
        }
      } else {
        throw Exception('Failed to find user: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during user lookup: $e');
      throw Exception('Error finding user: $e');
    }
  }

  Future<void> deleteMessage(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$tableName?id=eq.$id'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete message: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during delete: $e');
      throw Exception('Network error during delete: $e');
    }
  }
}




