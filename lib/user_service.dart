import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchUserInfo() async {
  try {
    final response =
        await http.get(Uri.parse('http://yourserver.com/get_user_info.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['error'] == null) {
        return data; // Return user info
      } else {
        // Handle error case (e.g., show a message)
        return null;
      }
    } else {
      throw Exception('Failed to load user info');
    }
  } catch (e) {
    // Handle any exceptions (e.g., network issues)
    print('Error fetching user info: $e');
    return null;
  }
}
