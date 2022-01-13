part of 'movies_cubit.dart';

@immutable
abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoaded extends MoviesState{
  final List<Results> movies;
  MoviesLoaded(this.movies);
}
