import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/screens/movie_details_screen.dart';

class MovieRow extends StatelessWidget {
  final MovieModel movie;

  MovieRow(this.movie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        avatarWidget(),
        movieDetails(context),
      ],
    );
  }

  Widget avatarWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: FadeInImage(
          height: 140,
          image: NetworkImage(movie.image),
          placeholder: AssetImage('assets/ic_launcher.png'),
        ),
      ),
    );
  }

  Widget movieDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        longTextWidget(context, movie.title, FontWeight.bold),
        SizedBox(height: 5),
        Text('Release at ${movie.releaseYear.toString()}'),
        SizedBox(height: 5),
        longTextWidget(context, movie.genre.toString().replaceAll('[', '').replaceAll(']', ''), FontWeight.normal),
        ratingWidget(),
        moreDetails(context),
      ],
    );
  }

  Widget longTextWidget(BuildContext context, String title, FontWeight fontWeight) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.8,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: fontWeight),
      ),
    );
  }

  Widget ratingWidget() {
    return Row(children: [
      Icon(Icons.star, color: Colors.amber),
      SizedBox(width: 5),
      Text(movie.rating.toString()),
    ]);
  }

  Widget moreDetails(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('More details'),
      ),
    );
  }
}
