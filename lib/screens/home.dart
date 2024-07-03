import 'package:flutter/material.dart';
import 'package:flutter_signup/models/movie_model.dart';
import 'package:flutter_signup/states/auth_state.dart';
import 'package:flutter_signup/utility/api_constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Movie> trendingMovies = [];

  static const Color red = Color(0xFFe33030); // red
  static const Color dark1 = Color(0xFF121212); // darkest
  static const Color dark2 = Color(0xFF292929); // dark
  static const Color silver = Color(0xFFa7a7a7); // silve

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
    final userProvider = Provider.of<AuthState>(context);
    final favoritesProvider = Provider.of<AuthState>(context);

    return Scaffold(
      
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40.0),
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: <Widget>[
                      Text(
                        'Trending Movies',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        
                        icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.purple[900]),
                      ),
                    ],
                  ),
                const SizedBox(height: 15.0),
                Expanded(
                child: ListView.builder(
                  itemCount: trendingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = trendingMovies[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.purple[900],
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: ListTile(
                        title: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${movie.overview.substring(0, 50)}...',
                          style: TextStyle(
                            color: Colors.purple[100]
                          )
                        ),
                        leading: CircleAvatar(
                          radius: 30.0, 
                          backgroundImage: NetworkImage('${Constants.imageBaseUrl}${movie.posterPath}'),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            userProvider.currentUser!.favorites.contains(movie)
                              ? favoritesProvider.unfavorite(userProvider.currentUser!, movie)
                              : favoritesProvider.favorite(userProvider.currentUser!, movie);
                          }, 
                          icon: Icon(
                            Icons.star_rounded, 
                            size: 25.0,
                            color: userProvider.currentUser!.favorites.contains(movie)
                              ? Colors.deepOrange
                              : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}
