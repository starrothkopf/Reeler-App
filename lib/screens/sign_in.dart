import 'package:flutter/material.dart';
import 'package:flutter_signup/widgets/styled_form_field.dart';
import 'package:flutter_signup/models/user_provider.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
 
  final _formGlobalKey = GlobalKey<FormState>();

  static const double _paddingHeight = 20.0;
  static const Color _tempoOrange =  Color.fromARGB(255, 248, 84, 4);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50,30,30,20),
                  child: SizedBox(
                    height: 100,
                    child: Image.asset('assets/tempologo.jpg'),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Image.asset('assets/tempokey.png'),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 194, 133),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Sign-In',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: _paddingHeight),
                    Form(
                      key: _formGlobalKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           const Text('Email', style: TextStyle(fontSize: 18.0)),
                          const SizedBox(height: 8),
                          StyledFormField(
                            child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  label: Text('Email ID'),
                                  hintText: 'Email ID',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  } else if (!value.contains('@') || value.length < 6) {
                                    return 'Please enter a valid email';
                                  } 
                                  return null;
                                },
                              ),
                          ),
                          const SizedBox(height: _paddingHeight),
                          const Text('Password', style: TextStyle(fontSize: 18.0)),
                          const SizedBox(height: 8),
                          StyledFormField(
                            child: TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  label: const Text('Enter Password'),
                                  hintText: 'Enter Password',
                                  suffixIcon: TextButton(
                                    onPressed: () {
                                      // Sending email to ${widget.currentUser.email}
                                    },
                                    child: const Text(
                                      'Forgot?',
                                      style: TextStyle(
                                        color: _tempoOrange,
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
                          const SizedBox(height: _paddingHeight),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formGlobalKey.currentState!.validate()) {
                                  _formGlobalKey.currentState!.save();
                                  if (userProvider.signIn(_emailController.text, _passwordController.text)) {
                                    Navigator.pushNamed(context, '/success');
                                  } else {
                                    Navigator.pushReplacementNamed(context, '/');
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _tempoOrange,
                                padding: const EdgeInsets.all(20.0),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: _paddingHeight + 10),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text('Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            TextButton(
                              child: const Text(
                                'Sign-Up!',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: _tempoOrange,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/');
                              }, 
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset('assets/tempobuddies.png')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}