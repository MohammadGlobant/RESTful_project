import 'package:flutter/material.dart';
import 'package:restful_project/AppRouter.dart';

void main() => runApp( MoviesApp(appRouter: AppRouter(),));

class MoviesApp extends StatelessWidget {
  final AppRouter appRouter;
  const MoviesApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}