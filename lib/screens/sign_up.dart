import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_signup/models/user_model.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/states/bool_state.dart';
import 'package:flutter_signup/widgets/styled_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  static const double _paddingHeight = 15.0;
  static const Color _red = Color(0xFFe33030); // red
  static const Color _silver = Color(0xFFa7a7a7);   // silver

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late String _username;
  late bool _rememberMe;

  final _formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
    void initState() {
      super.initState();
      _loadPreferences();
    }
  
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthState>(context, listen: false);
    final obscure = Provider.of<BoolState>(context);
    final checkbox = Provider.of<BoolState>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding( 
              padding: const EdgeInsets.fromLTRB(80, 100, 80, 0),
              child: SizedBox(
                height: 40,
                child: Image.asset('assets/reeler_full.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Find films you\'ll love',
                    style: TextStyle(
                      fontSize: 33.0,
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
                        Row( // first name, last name
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: TextFormField(
                                  controller: _firstNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    label: Text('First Name'),
                                    hintText: 'First Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    } 
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: TextFormField(
                                  controller: _lastNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    label: Text('Last Name'),
                                    hintText: 'Last Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    } 
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SignUp._paddingHeight),
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
                        const SizedBox(height: SignUp._paddingHeight),
                        StyledFormField(
                          child: TextFormField(
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obscure.value,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                label: const Text('Password'),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () => obscure.toggle(),
                                  icon: Icon(
                                    obscure.value
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24,
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
                        const SizedBox(height: SignUp._paddingHeight),
                        StyledFormField(
                          child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                label: Text('Confirm Password'),
                                hintText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm password';
                                } else if (value != _confirmPasswordController.text) {
                                  return 'Passwords do not match';
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
                                userProvider.signUp(User(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  favorites: [],
                                ));
                                Navigator.pushNamed(context, '/main');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SignUp._red,
                              padding: const EdgeInsets.all(20.0),
                            ),
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FormField<bool>( // check terms and conditions
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Checkbox(
                                      activeColor: SignUp._silver,
                                      value: checkbox.value,
                                      onChanged: (value) {
                                        checkbox.toggle();
                                      }),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(' I have read and agree to the',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: ' Terms & Conditions',
                                            style: const TextStyle(
                                              fontFamily: 'CircularStd',
                                              color: SignUp._silver,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {launchUrl(Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ'));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkbox.value) {
                              return 'Please accept the terms to create an account';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text('Already have an account?',
                      ),
                      TextButton(
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: SignUp._red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        }, 
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}