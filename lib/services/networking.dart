import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url = ''});

  final String url;

  Future<List> getData() async {
    if (url == '') {
      return [
        {'ERR': 'Url Empty'}
      ];
    }
    // Try HTTP request. Create Error Responses if unsuccesful
    try {
      http.Response response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        try {
          String data = response.body;
          List decodedData = json.decode(data);
          return decodedData;
        } catch (e) {
          print(e);
          return [
            {'ERR': 'Could not json decode payload'}
          ];
        }
      } else {
        print(response.statusCode);
        return [
          {'ERR': 'Invalid response'}
        ];
      }
    } catch (e) {
      print('ERR: $e');
      return [
        {'ERR': 'Could not connect'}
      ];
    }
  }
}
