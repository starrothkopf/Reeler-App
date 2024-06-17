import 'package:flutter_signup/models/movie_model.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String month;
  String day;
  String year;
  String password;
  List<Movie> favorites;

  User({required this.firstName, 
        required this.lastName, 
        required this.email, 
        required this.month, 
        required this.day, 
        required this.year,
        required this.password,
        required this.favorites});
        
}
