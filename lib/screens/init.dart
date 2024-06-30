import 'package:flutter/material.dart';

class Init extends StatelessWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context) {
  const Color red = Color(0xFFe33030); // red
  const Color dark1 = Color(0xFF121212); // darkest
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 100),
            SizedBox(
              height: 50.0,
              child: Image.asset('assets/reeler_white.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Discover curated films.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: -1,
              ),
            ),
            const Text(
              'Share with friends on Reeler.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  padding: const EdgeInsets.all(20.0),
                ),
                child: const Text(
                  'Sign up for free',
                  style: TextStyle(
                    color: dark1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}