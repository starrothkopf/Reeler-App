import 'package:flutter/material.dart';
import 'package:flutter_signup/models/user_provider.dart';
import 'package:provider/provider.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  static const Color _tempoOrange =  Color.fromARGB(255, 248, 84, 4);

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();

    if (userProvider.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/signin');
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          margin: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 242, 172, 115),
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
                height: 350,
                padding: const EdgeInsets.all(40.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                        color: _tempoOrange,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.mail, color: _tempoOrange, size: 12),
                        Text(
                          ' ${userProvider.currentUser?.email}',
                          style: const TextStyle(
                            color: _tempoOrange,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${userProvider.currentUser?.month}/${userProvider.currentUser?.day}/${userProvider.currentUser?.year}',
                      style: const TextStyle(
                        color: _tempoOrange,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
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
                          return Text(userProvider.currentUser!.favorites[index].title);
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
                          style: TextButton.styleFrom(backgroundColor: Colors.purple[800]),
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
                          style: TextButton.styleFrom(backgroundColor: _tempoOrange),
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
              const SizedBox(height: 15),
              const Text(
                'My Profiles', 
                style: TextStyle(
                  fontSize: 20.0, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: userProvider.validUsers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: ListTile(
                        onTap: () {
                          userProvider.currentUser = userProvider.validUsers[index];
                        },
                        title: Text('${userProvider.validUsers[index].firstName} ${userProvider.validUsers[index].lastName}'),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('profile.png'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.grey[600],
                          onPressed: () {
                            userProvider.remove(userProvider.validUsers[index]);
                          },
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}