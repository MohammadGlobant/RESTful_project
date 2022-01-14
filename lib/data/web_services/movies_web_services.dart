import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:restful_project/constants/endpoints.dart';
class MoviesWebServices{
  late Dio dio;

  MoviesWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: EndPoints.baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 seconds,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllMovies() async {
    Response response = await dio.get(EndPoints.allMovies);
    List<dynamic> responseData = jsonDecode(response.toString())['results'];
    return responseData;
  }


  Future<dynamic> getMovieDetails(String id) async {

    try {
      Response response = await dio.get(id+EndPoints.movieDetails);
      print(response.data.toString());
      print(id+"");
      return response.data;
    } catch (e) {
      print(id+"");
      print(e.toString());
      return [];
    }
  }
}