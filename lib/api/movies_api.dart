import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/db/movies_db.dart';
import 'package:movies/model/movie_model.dart';

class MoviesApi {
  static final client = http.Client();

  static Future<List<MovieModel>> getMovies() async {
    // If the movies exist in the local DB, retrieve it
    final List<MovieModel> movies = await MoviesDB.getMovies();
    if (movies != null) return movies;

    // else, get it from the network
    try {
      final response = await client.get(Uri.parse('http://api.androidhive.info/json/movies.json'));
      if (response.statusCode != 200) throw (response.body);
      final List moviesList = jsonDecode(response.body);
      await MoviesDB.insertMovies(moviesList);
      List<MovieModel> movies = moviesList.map((e) => MovieModel.fromJson(e)).toList();
      movies = movies..sort((a, b) => b.releaseYear.compareTo(a.releaseYear));
      return movies;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
