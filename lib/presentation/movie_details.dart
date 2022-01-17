import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_project/business_logic/movies_cubit.dart';
import 'package:restful_project/constants/endpoints.dart';
import 'package:restful_project/constants/project_colors.dart';
import 'package:restful_project/data/models/Details.dart';

class MovieDetails extends StatelessWidget {
  final String movieId;
  const MovieDetails({Key? key, required this.movieId}) : super(key: key);

  Widget buildSliverAppBar(Details details) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: ProjectColors.projectBlackColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "${details.originalTitle}+ mohammad",
          style: const TextStyle(color: ProjectColors.projectWhiteColor),
        ),
        background: Hero(
          tag: "${details.id}+ ",
          child: Image.network(
            EndPoints.movieImage + details.posterPath!,
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
      //return displayRandomDataOrEmptySpace(state);
      return const SizedBox(width: 10,);
    } else {
      return showProgressIndicator();
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
    print(movieId+" Details");
    BlocProvider.of<MoviesCubit>(context).getMovieInfo(movieId);
    return BlocBuilder<MoviesCubit,MoviesState>(builder: (context,state){
      if(state is DetailsLoaded) {
        Details details = (state).details.first;
        print(details.title.toString()+" Details");
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
                            'Original Language : ', details.originalLanguage!),
                        buildDivider(250),
                        movieInfo('Vote Count : ',
                            "${details.voteCount}"),
                        buildDivider(280),
                        movieInfo('Popularity : ',  "${details.popularity}"),
                        buildDivider(300),
                        const SizedBox(
                          height: 20,
                        ),
                        // BlocBuilder<MoviesCubit, MoviesState>(
                        //   builder: (context, state) {
                        //     return checkIfMovieDataAreLoaded(state);
                        //   },
                        // ),
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
      } else {
        return showProgressIndicator();
      }
    });
  }
}
