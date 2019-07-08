import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/pelicula_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  String selectedMovie = '';

  final _peliculasProvider = new PeliculaProvider();

  final movies = [
    'Spiderman 1',
    'Spiderman 2',
    'Spiderman 3',
    'Superman 1',
    'Superman 2',
    'Superman 3',
    'Aquaman',
    'Capintana Marvel',
    'Black panther',
    'Batman',
    'Deadpool',
    'Shazam',
    'Mujer maravilla',
    'Flash'
  ];

  final latestMovies = [
    'Spiderman 1',
    'Shazam'
  ];

  /*@override
  ThemeData appBarTheme( BuildContext context ) {
    final ThemeData theme = Theme.of( context );

    return theme.copyWith(
      primaryColor: Colors.blueGrey[ 700 ],
      primaryIconTheme: theme.primaryIconTheme.copyWith( color: Colors.white ),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme.copyWith(
        title: TextStyle( color: Colors.white )
      ),
    );
  }*/

  @override
  List<Widget> buildActions( BuildContext context ) {
    return [
      IconButton(
        icon: Icon( Icons.close ),
        onPressed: () => query = ''
      )
    ];
  }

  @override
  Widget buildLeading( BuildContext context ) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close( context, null )
    );
  }

  @override
  Widget buildResults( BuildContext context ) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey[ 700 ],
        height: 100.0,
        width: 100.0,
        child: Text(
          selectedMovie,
          style: TextStyle( color: Colors.white ),
        )
      ),
    );
  }

  @override
  Widget buildSuggestions( BuildContext context ) {
    return FutureBuilder(
      future: _peliculasProvider.searchMovies( query ),
      builder: ( BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot ) {
        if( snapshot.hasData ) {
          final movies = snapshot.data;

          return ListView(
            children: movies.map( ( movie ) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                  image: NetworkImage( movie.getPosterPath() ),
                  width: 50.0,
                  fit: BoxFit.cover
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.releaseDate ),
                onTap: () {
                  movie.uniqueId = '${movie.id}-search';

                  close( context, null );
                  Navigator.pushNamed( context, '/detail', arguments: movie );
                },
              );
            }).toList()
          );
        } else {
          return Container();
        }
      }
    );
  }

  /*@override
  Widget buildSuggestions( BuildContext context ) {
    final searchList = ( query.isEmpty ) 
                     ? latestMovies
                     : movies.where( 
                        ( p ) => p.toLowerCase().startsWith( query.toLowerCase() )
                    ).toList();

    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: ( BuildContext context, int index ) {
        return ListTile(
          leading: Icon( Icons.local_movies ),
          title: Text( searchList[ index ] ),
          onTap: () {
            selectedMovie = searchList[ index ];
            showResults( context );
          }
        );
      }
    );
  }*/

}