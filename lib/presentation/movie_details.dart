import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_project/business_logic/movies_cubit.dart';
import 'package:restful_project/constants/endpoints.dart';
import 'package:restful_project/constants/project_colors.dart';
import 'package:restful_project/data/models/Details.dart';
import 'package:restful_project/data/models/Results.dart';

class MovieDetails extends StatelessWidget {
  final Results movies;
  const MovieDetails({Key? key, required this.movies}) : super(key: key);

  Widget buildSliverAppBar(Details details) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: ProjectColors.projectBlackColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "${details.originalTitle}+ ",
          style: const TextStyle(color: ProjectColors.projectWhiteColor),
        ),
        background: Hero(
          tag: "${details.id}+ ",
          child: Image.network(
            "${EndPoints.movieImage}+${details.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget movieInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: ProjectColors.projectWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: ProjectColors.projectWhiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: ProjectColors.projectRedColor,
      thickness: 2,
    );
  }

  Widget checkIfMovieDataAreLoaded(MoviesState state) {
    if (state is DetailsLoaded) {
      return displayRandomDataOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomDataOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: ProjectColors.projectWhiteColor,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: ProjectColors.projectRedColor,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: ProjectColors.projectRedColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Details details = BlocProvider.of<MoviesCubit>(context).getMovieInfo("${movies.id}");
    return Scaffold(
      backgroundColor: ProjectColors.projectBlackColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(details),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movieInfo('Budget : ', "${details.budget}"),
                      buildDivider(315),
                      movieInfo(
                          'Original Language : ', details.originalLanguage),
                      buildDivider(250),
                      movieInfo('Vote Count : ',
                          "${details.voteCount}"),
                      buildDivider(280),
                      movieInfo('Popularity : ',  "${details.popularity}"),
                      buildDivider(300),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<MoviesCubit, MoviesState>(
                        builder: (context, state) {
                          return checkIfMovieDataAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
