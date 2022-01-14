import 'package:flutter/material.dart';
import 'package:restful_project/AppRouter.dart';
import 'package:restful_project/constants/endpoints.dart';
import 'package:restful_project/constants/project_colors.dart';
import 'package:restful_project/data/models/Results.dart';

class MovieItem extends StatelessWidget {
  final Results movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: ProjectColors.projectWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRouter.movieDetalisScreen , arguments: movie),
        child: GridTile(
          child: Hero(
            tag: movie.id,
            child: Container(
              color: ProjectColors.projectBlackColor,
              child: movie.posterPath.isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/images/loading.gif',
                image: EndPoints.movieImage+movie.posterPath,
                fit: BoxFit.cover,
              )
                  : Image.asset('assets/images/no_internet.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              movie.title,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: ProjectColors.projectWhiteColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
