import 'package:flutter_signup/models/movie_model.dart';
import '../../models/failure_model.dart';
import '../../models/user_model.dart';
import '../../utility/enums.dart';
import 'base_state.dart';

class AuthState extends BaseState { 
  
  AuthStatus authStatus = AuthStatus.intial;
  AppState _authViewState = AppState.intial;

  User? _user;  
  String _email = "";
  String _password = "";
  String _name = '';
  String _confirmPassword = '';
  Failure? _failure;

  @override
  Failure? get failure => _failure;

  String get name => _name;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  String get email => _email;

  AppState get authViewState => _authViewState;

  set setAuthViewState(AppState authViewState) => _authViewState = authViewState;

  User? get user => _user;

  set setUserProfile(User? user) {
    _user = user;
  }

  void onEmailChanges(String email) {
    _email = email;
    notifyListeners();
  }

  void onPasswordChanges(String password) {
    _password = password;
    notifyListeners();
  }

  void onConfirmPasswordChanges(String val) {
    _confirmPassword = val;
    notifyListeners();
  }

  void onNameChanges(String val) {
    _name = val;
    notifyListeners();
  }

  final List<User> _validUsers = [
    User(
      firstName: 'Star',
      lastName: 'Rothkopf',
      email: 'star@gmail.com',
      password: 'password',
      favorites: [],
    ),
  ];
  User? _currentUser;

  List<User> get validUsers => _validUsers;
  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  User? findUserByEmail(String email) {
    for (User user in _validUsers) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  void remove(User user) {
    _validUsers.remove(user);
    if (currentUser == user) {
      currentUser = null; // Set currentUser to null if the removed user was the current user
    }
    notifyListeners(); // rebuild the widgets that depend on this model
  }

  void signUp(User user) {
    if (!_validUsers.any((u) => u.email == user.email)) {
      _validUsers.add(user);
      _currentUser = user;
      notifyListeners();
    }
  }

  bool signIn(String email, String password) {
    User? user = findUserByEmail(email);
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
