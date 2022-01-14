import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_project/business_logic/movies_cubit.dart';
import 'package:restful_project/data/models/Details.dart';
import 'package:restful_project/data/models/Results.dart';
import 'package:restful_project/data/repository/movies_repository.dart';
import 'package:restful_project/data/web_services/movies_web_services.dart';
import 'package:restful_project/presentation/movie_details.dart';
import 'package:restful_project/presentation/movies_screen.dart';

class AppRouter {
  late MoviesRepository moviesRepository;
  late MoviesCubit moviesCubit;
  static const moviesScreen = '/';
  static const movieDetalisScreen = "/movie_details";
  AppRouter() {
    moviesRepository = MoviesRepository(MoviesWebServices());
    moviesCubit = MoviesCubit(moviesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => moviesCubit,
            child: const MoviesScreen(),
          ),
        );

      case movieDetalisScreen:
        final movies = settings.arguments as Results;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => MoviesCubit(moviesRepository),
            child: MovieDetails(
              movies: movies,
            ),
          ),
        );
    }
  }
}
