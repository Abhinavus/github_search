import 'dart:convert';
import 'package:github_search/repo.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchAlbum(String user) async {
  final response = await http
      .get(Uri.parse('https://api.github.com/search/users?q=abhinavu'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
