import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/model/movie_model.dart';

class MoviesDB {
  static Box moviesBox;

  static initDB() async {
    await Hive.initFlutter();
    // Open a box once
    await Hive.openBox('movies');
    // use singleton instance of an already opened box
    moviesBox = Hive.box('movies');
  }

  static Future insertMovies(List moviesList) async {
    // Insert the movies lists from the API to the local DB.
    // This code run only once, when the 'moviesList' is empty.
    // Sorting also, run only once.
    moviesList = moviesList..sort((a, b) => b['releaseYear'].compareTo(a['releaseYear']));
    await moviesBox.put('moviesList', moviesList);
  }

  static Future<List<MovieModel>> getMovies() async {
    // Get the movies from the local DB, if it's empty, the 'get' function return null;
    final List moviesList = moviesBox.get('moviesList');
    List<MovieModel> movies = moviesList != null ? moviesList.map((e) => MovieModel.fromJson(e)).toList() : null;
    return movies;
  }
}
