import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_signup/models/user.dart';
import 'package:flutter_signup/screens/sign_in.dart';
import 'package:flutter_signup/screens/success.dart';
import 'package:flutter_signup/widgets/styled_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  final User currentUser;
  final List<User> validUsers;
  
  const SignUp({super.key, required this.currentUser, required this.validUsers});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formGlobalKey = GlobalKey<FormState>();

  static final List<int> _validMonths = List.generate(12, (index) => index + 1);
  static final List<int> _validDays = List.generate(31, (index) => index + 1);

  static const double _paddingHeight = 20.0;
  static const Color _tempoOrange =  Color.fromARGB(255, 248, 84, 4);

  bool _checkboxValue = false;
  String _confirmPassword = '';
  bool _obscured = true;

  void _toggleObscured() { // toggles password show/hide
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                  onSaved: (value) {
                                    widget.currentUser.firstName = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: TextFormField(
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
                                  onSaved: (value) {
                                    widget.currentUser.lastName = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: _paddingHeight),
                        StyledFormField(
                          child: TextFormField(
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
                                } else if (!value.contains('@') || !value.contains('.') || value.length < 6) {
                                  return 'Please enter a valid email';
                                } 
                                return null;
                              },
                              onSaved: (value) {
                                widget.currentUser.email = value!;
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
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    label: Text('Month'),
                                  ),
                                  items: _validMonths.map((m) {
                                    return DropdownMenuItem(
                                      value: m,
                                      child: Text('$m')
                                    );
                                  }).toList(), 
                                  validator: (value) {
                                      if (value == null) {
                                        return 'Please select a month';
                                      }
                                      return null;
                                  },
                                  onChanged: (value) {}, // required
                                  onSaved: (value) {
                                    widget.currentUser.month = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    label: Text('Day'),
                                  ),
                                  items: _validDays.map((d) {
                                    return DropdownMenuItem(
                                      value: d,
                                      child: Text('$d')
                                    );
                                  }).toList(), 
                                  validator: (value) {
                                      if (value == null) {
                                        return 'Please select a date';
                                      }
                                      return null;
                                  },
                                  onChanged: (value) {}, // required
                                  onSaved: (value) { 
                                    widget.currentUser.day = value!;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: StyledFormField(
                                child: TextFormField(
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
                                  onSaved: (value) {
                                    widget.currentUser.year = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: _paddingHeight),
                        StyledFormField(
                          child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscured,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                label: const Text('Password'),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: _toggleObscured,
                                  icon: Icon(
                                    _obscured
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
                              onChanged: (value) {
                                _confirmPassword = value;
                              },
                            ),
                        ),
                        const SizedBox(height: _paddingHeight),
                        StyledFormField(
                          child: TextFormField(
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
                                } else if (value != _confirmPassword) {
                                  return 'Passwords do not match';
                                } 
                                return null;
                              },
                              onSaved: (value) {
                                widget.currentUser.password = value!;
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
                                if (!widget.validUsers.contains(widget.currentUser)) {
                                  widget.validUsers.add(widget.currentUser);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Success(currentUser: widget.currentUser, validUsers: widget.validUsers),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(currentUser: widget.currentUser, validUsers: widget.validUsers),
                                    ),
                                  );
                                }
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
                                      value: _checkboxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkboxValue = value!;
                                          state.didChange(value);
                                        });
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
                            if (!_checkboxValue) {
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(currentUser: widget.currentUser, validUsers: widget.validUsers),
                            ),
                          );
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