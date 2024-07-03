import 'package:flutter/material.dart';
import 'package:flutter_signup/models/movie_model.dart';
import 'package:flutter_signup/screens/home.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/states/screen_state.dart';
import 'package:flutter_signup/utility/api_constants.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  

  static const Color red = Color(0xFFe33030); // red
  static const Color dark1 = Color(0xFF121212); // darkest
  static const Color dark2 = Color(0xFF292929); // dark
  static const Color silver = Color(0xFFa7a7a7); //silver
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Movie> trendingMovies = [];
  
  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final List<Movie> fetchedMovies = await Movie.getMovies();
      setState(() {
        trendingMovies = fetchedMovies;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<AuthState>();
    final favoritesProvider = Provider.of<AuthState>(context);
    final screenIndexProvider = Provider.of<ScreenState>(context);
    int screenIndex = screenIndexProvider.fetchScreenIndex;

    if (userProvider.currentUser == null) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
    
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => screenIndexProvider.updateScreenIndex(value),
        indicatorColor: MainScreen.dark1,
        animationDuration: const Duration(seconds: 1),
        backgroundColor: MainScreen.dark1,
        elevation: 1.5,
        selectedIndex: screenIndex,
        height: 60,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white, size: 35.0),
            icon: Icon(Icons.home_outlined, color: MainScreen.silver, size: 35.0),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.white, size: 35.0),
            icon: Icon(Icons.search_outlined, color: MainScreen.silver, size: 35.0),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark, color: Colors.white, size: 35.0),
            icon: Icon(Icons.bookmark_border, color: MainScreen.silver, size: 35.0),
            label: 'Library',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people, color: Colors.white, size: 35.0),
            icon: Icon(Icons.people_outlined, color: MainScreen.silver, size: 35.0),
            label: 'Friends',
          ),
        ],
      ),
      body: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
              height: 55,
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    maxRadius: 15.0,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.red,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text(' All ', style: TextStyle(color: MainScreen.dark1))
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.dark2,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text('Films', style: TextStyle(color: Colors.white))
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.dark2,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text('Television', style: TextStyle(color: Colors.white))
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.dark2,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text('Indie', style: TextStyle(color: Colors.white))
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.dark2,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text('Horror', style: TextStyle(color: Colors.white))
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: MainScreen.dark2,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text('Romance', style: TextStyle(color: Colors.white))
                        ),
                      ]
                    ),
                  ),
                ]
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 250,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          childAspectRatio: (3 / 1.1),
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(8, (index) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: MainScreen.dark2,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              margin: const EdgeInsets.all(3.5),
                              child: Center(
                                child: Text(
                                  'Item $index',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            );
                          },)
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height:10),
                      const Text(
                        'Trending films',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingMovies.length,
                          itemBuilder: (context, index) { 
                            final movie = trendingMovies[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              width: 120,
                              child: Column(
                                children: <Widget>[
                                  Image.network('${Constants.imageBaseUrl}${movie.posterPath}'),
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${movie.overview.substring(0, 25)}...',
                                    style: const TextStyle(
                                      color: Color(0xFFa7a7a7),
                                    )
                                  ),
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
        const Text('Search page'),
        const Text('Library page'),
        const Text('Friends page'),
      ][screenIndex],

      // body: Center(
      //   child: Container(
      //     margin: const EdgeInsets.all(20.0),
      //     decoration: const BoxDecoration(
            
      //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
      //     ),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text(
      //           'Hi, ${userProvider.currentUser?.firstName}!', 
      //           style: const TextStyle(
      //             fontSize: 40.0, 
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold
      //           ),
      //         ),
      //         const SizedBox(height: 15),
      //         Container(
      //           height: 330,
      //           padding: const EdgeInsets.all(40.0),
      //           decoration: const BoxDecoration(
      //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
      //             color: dark2,
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               const Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   CircleAvatar(
      //                     maxRadius: 40.0,
      //                     backgroundImage: AssetImage('assets/profile.png'),
      //                   ),
      //                   SizedBox(
      //                     width: 200,
      //                     child: Column(
      //                       children: <Widget>[
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: <Widget>[
      //                             Column(
      //                               children: <Widget>[
      //                                 Text('0'),
      //                                 Text('posts'),
      //                               ],
      //                             ),
      //                             Column(children: <Widget>[
      //                               Text('0'),
      //                               Text('followers'),
      //                               ],
      //                             ),
      //                             Column(children: <Widget>[
      //                               Text('0'),
      //                               Text('following'),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //               const SizedBox(height: 15),
      //               Text(
      //                 '${userProvider.currentUser?.firstName} ${userProvider.currentUser?.lastName}',
      //                 style: const TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 18.0,
      //                   fontWeight: FontWeight.bold,
      //                 )
      //               ),
      //               Row(
      //                 children: <Widget>[
      //                   const Icon(Icons.mail, color: red, size: 12),
      //                   Text(
      //                     ' ${userProvider.currentUser?.email}',
      //                     style: const TextStyle(
      //                       color: silver,
      //                       fontSize: 13.0,
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(height: 5),
      //               const Text(
      //                 'My favorite trending movies:',
      //                 style: TextStyle(
      //                   fontSize: 13.0,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 40,
      //                 child: ListView.builder(
      //                   itemCount: userProvider.currentUser!.favorites.length,
      //                   itemBuilder: (context, index) {
      //                     return CircleAvatar(
      //                       radius: 20.0,
      //                       backgroundImage: NetworkImage('${Constants.imageBaseUrl}${userProvider.currentUser!.favorites[index].posterPath}'),
      //                     );
      //                   }
      //                 ),
      //               ),
      //               const SizedBox(height: 15),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: <Widget>[
      //                   TextButton(
      //                     onPressed: () {
      //                       Navigator.pushNamed(context, '/movies');
      //                     },
      //                     style: TextButton.styleFrom(backgroundColor: red),
      //                     child: const Row(
      //                       children: <Widget>[
      //                       Text(
      //                         'Select Movies ',
      //                         style: TextStyle(
      //                           fontSize: 15.0,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                       Icon(Icons.movie, color: Colors.white, size: 20),
      //                       ],
      //                     ),
      //                   ),
      //                   const SizedBox(width: 10),
      //                   TextButton(
      //                     style: TextButton.styleFrom(backgroundColor: red),
      //                     child: const Row(
      //                       children: <Widget>[
      //                         Text(
      //                         'Log Out ',
      //                         style: TextStyle(
      //                           fontSize: 15.0,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                         Icon(Icons.logout, color: Colors.white, size: 20),
      //                       ],
      //                     ),
      //                     onPressed: () {
      //                       Navigator.pushReplacementNamed(context, '/signin');
      //                     }, 
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}