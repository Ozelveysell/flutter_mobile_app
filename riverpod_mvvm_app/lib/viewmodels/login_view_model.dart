import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final loginViewModelProvider = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  String? _errorMessage;
  String? _token;

  String? get errorMessage => _errorMessage;
  String? get token => _token;

  void validateUser(String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'] as String;
        _token = token;
        await storage.write(key: 'token', value: token); // Token'ı yerel depolamaya kaydet
        _errorMessage = null;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/home'); // Başarılı girişte ana sayfaya yönlendirme
      } else {
        throw Exception('Giriş sırasında bir hata oldu');
      }
    } catch (e) {
      _errorMessage = 'Giriş sırasında bir hata oldu: $e';
      notifyListeners();
    }
  }
}
