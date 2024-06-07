import 'package:http/http.dart' as http; 
import 'dart:convert';


class EmailVerification {
  final String accountId = 'flutteruser'; // 'your-account-id'
  final String authToken = 'password123'; // 'your-auth-token'

  Future<bool> verifyEmail(String email) async { // temporarily returns placeholder until function is complete
      
    final uri = Uri.parse('https://api.verifalia.com/v2.0/email-validations');
    final credentials = base64Encode(utf8.encode('$accountId:$authToken'));

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'entries': [
          {'inputData': email}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final status = result['entries'][0]['classification'];
      return status == 'Deliverable'; // true if Deliverable
    } else {
      throw Exception('Failed to verify email');
    }
  }
}

