import 'base_state.dart';

class BoolState extends BaseState { 
  bool _value = true;
  bool get value => _value;
  void toggle() { 
    _value = !_value;
    notifyListeners();
  }
}