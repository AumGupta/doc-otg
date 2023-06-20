import 'package:http/http.dart' as http;
import 'dart:convert';

String _apiResponse = '';
Future<String> sendData(Map data) async {
  var url = Uri.parse('https://docotg.onrender.com/text');
  Map requestBody = data;
  // Map requestBody = {
  //   "cough": "True",
  //   "fever": "True",
  //   "sore_throat": "True",
  //   "shortness_of_breath": "True",
  //   "headache": "True",
  //   "old_age": "True",
  //   "contact": "True"
  // };

  try {
    var response = await http.post(
      url,
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _apiResponse = '$data';
    } else {
      _apiResponse = 'Error: ${response.statusCode}';
    }
  } catch (e) {
    _apiResponse = 'Error: $e';
  }
  return _apiResponse.toString();
}
