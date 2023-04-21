import 'dart:convert';
import 'package:http/http.dart';
import 'package:movie_list_project/model/moviemodel.dart';

class MovieRepository {
  static const String apiKey = "c7af162254f9af621ae833e27e3ee63f";
  String baseUrl = 'https://api.themoviedb.org/3/search/movie';

  Future<List<MovieDetails>> getMovies(String query) async {
    final Response response =
        await get(Uri.parse("$baseUrl?api_key=$apiKey&query=$query"));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['results'];
      return result.map((e) => MovieDetails.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
