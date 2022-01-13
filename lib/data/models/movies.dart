import 'Results.dart';

class Movies {
  late List<dynamic> results;

  Movies.fromJson(Map<String, dynamic> json) {

    results = json['results'];
  }

}

