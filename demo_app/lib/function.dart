import 'package:http/http.dart' as http;

fetchdata(String url) async {
  final headers = {'Content-Type': 'application/json'};
  http.Response response = await http.post(Uri.parse(url), headers: headers);
  return response.body;
}
