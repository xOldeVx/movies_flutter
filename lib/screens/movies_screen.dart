import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/screens/qr_screen.dart';
import 'package:movies/widgets/movie_row.dart';

import 'movie_details_screen.dart';

class MoviesScreen extends StatefulWidget {
  final List<MovieModel> movies;

  MoviesScreen(this.movies);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Movies'))),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.movies.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () => getMovieDetailsScreen(widget.movies[i]),
            child: MovieRow(widget.movies[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => triggerQR(),
        tooltip: 'Add movie',
        child: Icon(Icons.add),
      ),
    );
  }

  void triggerQR() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRScreen()));
    if (result != null) {
      MovieModel qrMovie = MovieModel.fromJson(jsonDecode(result.code));
      // Check if the movie exist
      for (MovieModel movie in widget.movies) {
        if (qrMovie.title == movie.title) {
          return snackBar('This movie is exist');
        }
      }
      // todo MoviesDB.addMovie(qrMovie);
      snackBar('Movie added successfully');
    }
  }

  void snackBar(String body) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body)));
  }

  void getMovieDetailsScreen(MovieModel movie) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie)));
  }
}
