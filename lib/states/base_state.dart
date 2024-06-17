import 'package:flutter/material.dart';

import '../../models/failure_model.dart';
import '../../utility/enums.dart';

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
}
