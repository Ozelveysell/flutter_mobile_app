import 'package:http/http.dart' as http;

class UserRepository {
  Future<void> loginWithToken(String token) async {
    final url = Uri.parse('https://reqres.in/api/token-login'); // Replace with your actual API endpoint

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Successful login logic
        // Process user data or save token as needed
      } else {
        throw Exception('Failed to login with token');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login with token');
    }
  }
}
