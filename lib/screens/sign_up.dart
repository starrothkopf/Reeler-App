import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_signup/models/user.dart';
import 'package:flutter_signup/models/user_provider.dart';
import 'package:flutter_signup/widgets/styled_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_signup/services/email_verification.dart';

// toggle password show/hide and form checkbox
class BoolToggle with ChangeNotifier {
  bool _value = true;
  bool get value => _value;
  void toggle() { 
    _value = !_value;
    notifyListeners();
  }
}

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formGlobalKey = GlobalKey<FormState>();

  static const double _paddingHeight = 20.0;
  static const Color _tempoOrange =  Color.fromARGB(255, 248, 84, 4);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final obscure = Provider.of<BoolToggle>(context);
    final checkbox = Provider.of<BoolToggle>(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding( 
              padding: const EdgeInsets.all(_paddingHeight),
              child: SizedBox(
                height: 100,
                child: Image.asset('assets/tempologo.jpg'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 194, 133),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Create Account',
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
                        const SizedBox(height: _paddingHeight),
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
                        const SizedBox(height: 10),
                        const Text('Date of Birth'),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: TextFormField(
                                  controller: _monthController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    label: Text('Month #'),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a month';
                                    }
                                    final int? month = int.tryParse(value);
                                    if (month == null || month < 1 || month > 12) {
                                      return 'Must be 1-12';
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
                                  controller: _dayController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    label: Text('Day #'),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter day';
                                    }
                                    final int? day = int.tryParse(value);
                                    if (day == null || day < 1 || day > 31) {
                                      return 'Must be 1-31';
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
                                  controller: _yearController,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    label: Text('Year'),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter year';
                                    }
                                    final int? year = int.tryParse(value);
                                    if (year == null || year < 1900 || year > 2024) {
                                      return 'Please enter a valid year';
                                    }
                                    return null; 
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: _paddingHeight),
                        StyledFormField(
                          child: TextFormField(
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obscure._value,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                label: const Text('Password'),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () => obscure.toggle(),
                                  icon: Icon(
                                    obscure._value
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
                        const SizedBox(height: _paddingHeight),
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
                        const SizedBox(height: _paddingHeight),
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
                                  month: _monthController.text,
                                  day: _dayController.text,
                                  year: _yearController.text,
                                  password: _passwordController.text,
                                  favorites: [],
                                ));
                                Navigator.pushNamed(context, '/success');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _tempoOrange,
                              padding: const EdgeInsets.all(20.0),
                            ),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: _paddingHeight + 10),
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
                                      value: checkbox._value,
                                      onChanged: (value) {
                                        checkbox.toggle();
                                      }),
                                    Row(
                                      children: <Widget>[
                                        const Text(' I have read and agree to the',
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: ' Terms & Conditions',
                                            style: TextStyle(
                                              color: Colors.purple[900],
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
                                Text(
                                  state.errorText ?? '',
                                  style: TextStyle(
                                    color: Colors.red[900],
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkbox._value) {
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
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign-In!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: _tempoOrange,
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