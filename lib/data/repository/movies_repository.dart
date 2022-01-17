import 'package:restful_project/data/models/Details.dart';
import 'package:restful_project/data/models/Results.dart';
import 'package:restful_project/data/web_services/movies_web_services.dart';

class MoviesRepository{
  final MoviesWebServices moviesWebServices;

  MoviesRepository(this.moviesWebServices);

  Future<List<Results>> getAllMovies() async {
    final movies = await moviesWebServices.getAllMovies();
    return movies.map((movie) => Results.fromJson(movie)).toList();
  }

  Future<List<Details>> getMovieDetails(String id) async {
    final movieDetails = await moviesWebServices.getMovieDetails(id);
    print(" movies repository  "+id);
    return movieDetails.map((movieDetail) => Details.fromJson(movieDetail)).toList();
  }

}