import 'package:http/http.dart' as http; 
import 'dart:convert';

class Constants {
  static String apiKey = 'e10b23ad979aae8c6c4dbcfcaca90d34';
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
}

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  static Future<List<Movie>> getMovies() async { // temporarily returns placeholder until function is complete
    final response = await http.get(Uri.parse(
      '${Constants.baseUrl}/movie/popular?api_key=${Constants.apiKey}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}