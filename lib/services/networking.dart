import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url = ''});

  final String url;

  Future getData() async {
    if (url == '') {
      return 'ERROR: empty url';
    }
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      try {
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } catch (e) {
        return 'Exception Occured: $e';
      }
    } else {
      print(response.statusCode);
    }
  }
}
