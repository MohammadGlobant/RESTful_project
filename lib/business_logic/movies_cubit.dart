import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restful_project/data/models/Details.dart';
import 'package:restful_project/data/models/Results.dart';
import 'package:restful_project/data/repository/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;
  List<Results> movies = [];
  List<Details> details = [];

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  List<Results> getAllMovies() {
    moviesRepository.getAllMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }

  void getMovieInfo(String id){
    moviesRepository.getMovieDetails(id).then((details){
      emit(DetailsLoaded(details));
      this.details = details;
    });
  }

}
