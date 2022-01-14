class Details {
  late String backdropPath;
  late int budget;
  late int id;
  late String imdbId;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late double voteAverage;
  late int voteCount;

  Details.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    budget = json['budget'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

