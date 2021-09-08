import 'dart:convert';
import 'package:galon/token/token.dart';
import 'package:http/http.dart' as http;

Future getInfo() async {
  String url = 'https://gebyarairminumbiru.com/api/user/info';

  var response = await http.get(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer" + await Token().getAccessToken(),
      //access token dlm bentuk bearer //disini udh ada auth untuk access
    },
  );
  //var toJson = jsonDecode(response.body);
  if (response.statusCode == 200) {
    final res = json.decode(response.body);
    Token().saveUserData(json.encode(res));
    return response.body;
  } else {
    // throw Exception("Failed to load data");
    throw response;
  }
}
