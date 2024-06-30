import 'package:flutter/material.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/utility/api_constants.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const Color red = Color(0xFFe33030); // red
  static const Color dark1 = Color(0xFF121212); // darkest
  static const Color dark2 = Color(0xFF292929); // dark
  static const Color silver = Color(0xFFa7a7a7); // silver

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<AuthState>();

    if (userProvider.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/signin');
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          margin: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi, ${userProvider.currentUser?.firstName}!', 
                style: const TextStyle(
                  fontSize: 40.0, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 330,
                padding: const EdgeInsets.all(40.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: dark2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          maxRadius: 40.0,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('0'),
                                      Text('posts'),
                                    ],
                                  ),
                                  Column(children: <Widget>[
                                    Text('0'),
                                    Text('followers'),
                                    ],
                                  ),
                                  Column(children: <Widget>[
                                    Text('0'),
                                    Text('following'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${userProvider.currentUser?.firstName} ${userProvider.currentUser?.lastName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.mail, color: red, size: 12),
                        Text(
                          ' ${userProvider.currentUser?.email}',
                          style: const TextStyle(
                            color: silver,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'My favorite trending movies:',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: userProvider.currentUser!.favorites.length,
                        itemBuilder: (context, index) {
                          return CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage('${Constants.imageBaseUrl}${userProvider.currentUser!.favorites[index].posterPath}'),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/movies');
                          },
                          style: TextButton.styleFrom(backgroundColor: red),
                          child: const Row(
                            children: <Widget>[
                            Text(
                              'Select Movies ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            Icon(Icons.movie, color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          style: TextButton.styleFrom(backgroundColor: red),
                          child: const Row(
                            children: <Widget>[
                              Text(
                              'Log Out ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.logout, color: Colors.white, size: 20),
                            ],
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
      ),
    );
  }
}