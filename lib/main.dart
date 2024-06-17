import 'package:flutter/material.dart';
import 'package:flutter_signup/states/shared_prefs_state.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/screens/movies.dart';
import 'package:flutter_signup/screens/sign_in.dart';
import 'package:flutter_signup/screens/sign_up.dart';
import 'package:flutter_signup/screens/success.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthState()),
      ChangeNotifierProvider(create: (context) => BoolToggle()),
      Provider<SharedPreferencesProvider>(create: (_) => SharedPreferencesProvider(SharedPreferences.getInstance())),
      StreamProvider(create: (context) => context.read<SharedPreferencesProvider>().prefsState, initialData: null)
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