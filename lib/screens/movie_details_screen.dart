import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/widgets/image_clipper.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieModel movie;

  MovieDetailsScreen(this.movie);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => setState(() => isLiked = !isLiked),
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              avatarWidget(),
              Positioned(
                child: playWidget(),
                bottom: 25,
              ),
            ],
          ),
          detailsWidget(),
        ],
      ),
    );
  }

  Widget avatarWidget() {
    return ClipPath(
      clipper: ImageClipper(),
      child: FadeInImage(
        width: double.infinity,
        image: NetworkImage(widget.movie.image),
        placeholder: AssetImage('assets/ic_launcher.png'),
      ),
    );
  }

  Widget playWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, offset: Offset.zero, color: Colors.black.withOpacity(0.5))]),
      child: Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 55,
      ),
    );
  }

  Widget detailsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.movie.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text('genre: ${widget.movie.genre.toString().replaceAll('[', '').replaceAll(']', '')}'),
        SizedBox(height: 10),
        Text('release at ${widget.movie.releaseYear.toString()}'),
        SizedBox(height: 10),
        ratingWidget(),
      ],
    );
  }

  Widget ratingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.amber),
        SizedBox(width: 5),
        Text(widget.movie.rating.toString()),
      ],
    );
  }
}
