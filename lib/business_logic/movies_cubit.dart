import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restful_project/data/models/Results.dart';
import 'package:restful_project/data/models/movies.dart';
import 'package:restful_project/data/repository/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;
  List<Results> movies = [];

  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  List<Results> getAllMovies() {
    moviesRepository.getAllMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });

    return movies;
  }

}
