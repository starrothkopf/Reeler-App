import 'package:flutter/material.dart';
import 'package:flutter_signup/models/user.dart';
import 'package:flutter_signup/screens/sign_up.dart';

void main() => runApp(MaterialApp(
    title: 'Tempo Sign In',
    theme: ThemeData(scaffoldBackgroundColor: Colors.white),
    initialRoute: '/',
    routes: {
      '/': (context) => SignUp(
        currentUser: User( // pass a blank user
          firstName: '',
          lastName: '',
          email: '',
          month: 1,
          day: 1,
          year: '',
          password: '',
        ),
        validUsers: [], // can't be const, add to later
      ),
    }
));