import 'package:flutter/material.dart';
import 'package:flutter_signup/models/user.dart';
import 'package:flutter_signup/screens/sign_in.dart';

class Success extends StatefulWidget {
  final User currentUser;
  final List<User> validUsers;

  const Success({super.key, required this.currentUser, required this.validUsers});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  static const Color _tempoOrange =  Color.fromARGB(255, 248, 84, 4);

  @override
  Widget build(BuildContext context) {
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
                'Hi, ${widget.currentUser.firstName}!', 
                style: const TextStyle(
                  fontSize: 40.0, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 310,
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
                      '${widget.currentUser.firstName} ${widget.currentUser.lastName}',
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
                          ' ${widget.currentUser.email}',
                          style: const TextStyle(
                            color: _tempoOrange,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.currentUser.month}/${widget.currentUser.day}/${widget.currentUser.year}',
                      style: const TextStyle(
                        color: _tempoOrange,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Livin\' life at my own tempo!',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(backgroundColor: _tempoOrange),
                          child: const Row(
                            children: <Widget>[
                            Text(
                              'Edit Profile ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            Icon(Icons.edit, color: Colors.white, size: 20),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(
                                  currentUser: User( // pass a blank user
                                  firstName: '',
                                  lastName: '',
                                  email: '',
                                  month: 1,
                                  day: 1,
                                  year: '',
                                  password: '',
                                ),
                                validUsers: widget.validUsers),
                              ),
                            );
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
                  itemCount: widget.validUsers.length,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Success(
                                currentUser: widget.validUsers[index],
                                validUsers: widget.validUsers,
                              ),
                            ),
                          );
                        },
                        title: Text('${widget.validUsers[index].firstName} ${widget.validUsers[index].lastName}'),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('profile.png'),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.grey[600],
                          onPressed: () {
                            widget.validUsers.remove(widget.validUsers[index]);
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