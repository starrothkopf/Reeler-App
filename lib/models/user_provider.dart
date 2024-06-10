import 'package:flutter/material.dart';
import 'package:flutter_signup/models/movie.dart';
import 'user.dart';

class UserProvider with ChangeNotifier {
  final List<User> _validUsers = [];
  User? _currentUser;

  List<User> get validUsers => _validUsers;
  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  void signUp(User user) {
    if (!_validUsers.any((u) => u.email == user.email)) {
      _validUsers.add(user);
      _currentUser = user;
      notifyListeners();
    }
  }

  User? findUserByEmail(String email) {
    for (User user in _validUsers) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  bool signIn(String email, String password) {
    User? user = findUserByEmail(currentUser!.email);
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }

  void remove(User user) {
    _validUsers.remove(user);
    if (currentUser == user) {
      currentUser = null; // Set currentUser to null if the removed user was the current user
    }
    notifyListeners(); // rebuild the widgets that depend on this model
  }

  void favorite(User user, Movie movie) {
    if (!user.favorites.contains(movie)) {
      user.favorites.add(movie);
      notifyListeners();
    }
  }

  void unfavorite(User user, Movie movie) {
    if (user.favorites.contains(movie)) {
      user.favorites.remove(movie);
      notifyListeners();
    }
  }

}