import 'package:flutter/material.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/widgets/styled_form_field.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
 
  final _formGlobalKey = GlobalKey<FormState>();

  static const double _paddingHeight = 15.0;
  static const Color _red = Color(0xFFe33030); // red
  static const Color _dark1 = Color(0xFF121212); // darkest
  static const Color _dark2 = Color(0xFF292929); // dark
  static const Color _silver = Color(0xFFa7a7a7); // silver

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            SizedBox(
              height: 40,
              child: Image.asset('assets/reeler_full.png'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Back at the cinema',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StyledFormField(
                    child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          label: Text('Email'),
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!value.contains('@') || !value.contains('.')) { // _isValid
                            return 'Please enter a valid email';
                          } 
                          return null;
                        },
                      ),
                  ),
                const SizedBox(height: _paddingHeight),
                StyledFormField(
                  child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        label: const Text('Password'),
                        hintText: 'Password',
                        suffixIcon: TextButton(
                          onPressed: () {
                            // Sending email to ${widget.currentUser.email}
                          },
                          child: const Text(
                            'Forgot?',
                            style: TextStyle(
                              color: _silver,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } 
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, // wide button
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          bool attempt = userProvider.signIn(_emailController.text, _passwordController.text);
                          if (attempt) {
                            Navigator.pushNamed(context, '/main');
                          } else {
                            Navigator.pushReplacementNamed(context, '/signup');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _red,
                        padding: const EdgeInsets.all(20.0),
                      ),
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?',
                ),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: _red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  }, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}