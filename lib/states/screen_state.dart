import 'base_state.dart';

class ScreenState extends BaseState { 
  int screenIndex = 0;
  int get fetchScreenIndex {
    return screenIndex;
  }
  void updateScreenIndex (int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}