import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';
  static Future<Map> getJson() async {
    final apiKey = "";
    final apiEndPoint = "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=popularity.desc";
    final apiResponse = await http.get(Uri.parse(apiEndPoint));
    return json.decode(apiResponse.body);
  }
}