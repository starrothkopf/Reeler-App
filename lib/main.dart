import 'package:flutter/material.dart';
import 'package:flutter_signup/models/user_provider.dart';
import 'package:flutter_signup/screens/movies.dart';
import 'package:flutter_signup/screens/sign_in.dart';
import 'package:flutter_signup/screens/sign_up.dart';
import 'package:flutter_signup/screens/success.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => BoolToggle()),
    ],
    child: MaterialApp(
      title: 'Tempo Sign In',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      initialRoute: '/',
      routes: {
        '/': (context) => SignUp(),
        '/signin': (context) => SignIn(),
        '/movies': (context) => const Movies(),
        '/success': (context) => const Success(),
      }
    ),
  ),
);