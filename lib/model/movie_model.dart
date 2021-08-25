class MovieModel {
  String title, image;
  double rating;
  int releaseYear;
  List genre;

  MovieModel.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    image = json['image'];
    rating = json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating']; // When rating is int, convert it to double to avoid crash
    releaseYear = json['releaseYear'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['releaseYear'] = this.releaseYear;
    data['genre'] = this.genre;
    return data;
  }
}
