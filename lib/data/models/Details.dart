class Details {
   String backdropPath= "";
   int budget= 0;
   int id= 0;
   String imdbId= "";
   String originalLanguage= "";
   String originalTitle = "";
   String overview= "";
   double popularity= 0.0;
   String posterPath= "";
   String releaseDate= "";
   double voteAverage= 0.0;
   int voteCount= 0;

  Details(){}
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

