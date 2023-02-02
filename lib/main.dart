import 'package:flutter/material.dart';
import './movie_provider.dart';
import './movie_model.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie  App',
      home: const MovieListing(title: 'Movie App'),
    );
  }
}

class MovieListing extends StatefulWidget {
  const MovieListing({super.key, required this.title});
  final String title;

  @override
  State<MovieListing> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MovieListing> {

  List<MovieModel> movies = <MovieModel>[];
  int counter = 0;

  fetchMovies() async {
    var data = await MovieProvider.getJson();
    setState(() {
      counter++;
      List<dynamic> results = data['results'];

      results.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });

      // var len = movies.length;
      // print('Movies lenght: $len');
    });
  }

  @override
  void initState(){
    super.initState();

    fetchMovies();
    
   
  }

  @override
  Widget build(BuildContext context) {
    //fetchMovies();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
      ),
      body: ListView.builder(
        itemCount: movies == null ? 0 : movies.length,
        itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MovieTile(movies, index),

            );
        }
      )
    );
  }
}

class MovieTile extends StatelessWidget {
  final List<MovieModel> movies;
  final int index;

  MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          movies[index].poster_path != null ?
          Container(
            width: MediaQuery.of(context).size.width /2,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(MovieProvider.imagePathPrefix + movies[index].poster_path ),
                fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
              offset: Offset(1.0, 3.0),
              ),
            ]
            ),
          )
          : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].overview,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Divider(color: Colors.grey.shade500),
        ],
      ),
    );
  }
}