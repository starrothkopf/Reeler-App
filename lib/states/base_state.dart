import 'package:flutter/material.dart';
import 'package:flutter_signup/models/failure_model.dart';
import 'package:flutter_signup/utility/enums.dart';

class BaseState extends ChangeNotifier {
  AppState _appState = AppState.intial;
  Failure? _failure;

  AppState get appState => _appState;
  Failure? get failure => _failure;

  set setAppState(AppState state) {
    _appState = state;
    notifyListeners();
  }

  set setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  set setAppStateWithoutNotifier(AppState state) {
    _appState = state;
  }

  set setFailureWithoutNotifier(Failure failure) {
    _failure = failure;
  }
}