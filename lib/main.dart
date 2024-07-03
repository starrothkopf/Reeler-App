import 'package:flutter/material.dart';
import 'package:flutter_signup/screens/init.dart';
import 'package:flutter_signup/screens/home.dart';
import 'package:flutter_signup/screens/sign_in.dart';
import 'package:flutter_signup/screens/sign_up.dart';
import 'package:flutter_signup/screens/main_screen.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/states/bool_state.dart';
import 'package:flutter_signup/states/screen_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthState()),
      ChangeNotifierProvider(create: (context) => BoolState()),
      ChangeNotifierProvider(create: (context) => ScreenState()),
    ],
    child: MaterialApp(
      title: 'Reeler',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'CircularStd',
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Init(),
        '/signup': (context) => SignUp(),
        '/signin': (context) => SignIn(),
        '/movies': (context) => const Home(),
        '/main': (context) => const MainScreen(),
      }
    ),
  ),
);