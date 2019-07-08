import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/actor_provider.dart';

class MovieDetailPage extends StatelessWidget {
  final ActorProvider actorProvider = new ActorProvider();

  @override
  Widget build( BuildContext context ) {
    final Pelicula movie = ModalRoute.of( context ).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([
              _createHeader( context, movie ),
              _createBody( movie ),
              _createFooter( movie.id )
            ])
          )
        ]
      )
    );
  }

  Widget _createAppBar( Pelicula movie ) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.teal,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text( 
          movie.title,
          style: TextStyle( color: Colors.white, fontSize: 16.0 ) 
        ),
        background: FadeInImage(
          placeholder: AssetImage( 'assets/img/loading.gif' ),
          image: NetworkImage( movie.getBackdropPath() ),
          fadeInDuration: Duration( milliseconds: 750 ),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _createHeader( BuildContext context, Pelicula movie ) {
    return Container(
      padding: EdgeInsets.all( 15.0 ),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 15.0 ),
              child: Image(
                height: 150,
                image: NetworkImage( movie.getPosterPath() )
              ),
            ),
          ),
          SizedBox( width: 15.0 ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of( context ).textTheme.title,
                  overflow: TextOverflow.ellipsis
                ),
                SizedBox( height: 10.0 ),
                Text(
                  movie.originalTitle,
                  style: Theme.of( context ).textTheme.subhead,
                  overflow: TextOverflow.ellipsis
                ),
                SizedBox( height: 10.0 ),
                Text(
                  movie.releaseDate,
                  style: Theme.of( context ).textTheme.subhead
                ),
                SizedBox( height: 10.0 ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star, color: Colors.yellow[ 700 ] ),
                    SizedBox( width: 15.0 ),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of( context ).textTheme.subtitle
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createBody( Pelicula movie ) {
    return Container(
      padding: EdgeInsets.fromLTRB( 15.0, 0, 15.0, 15.0 ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify
      )
    );
  }

  Widget _createFooter( int movieId ) {
    return Container(
      padding: EdgeInsets.fromLTRB( 15.0, 0, 15.0, 15.0 ),
      child: FutureBuilder(
        future: actorProvider.getMovieCast( movieId ),
        builder: ( BuildContext context, AsyncSnapshot<List<Actor>> snapshot ) {
          if( snapshot.hasData ) {
            return _createFooterPageView( context, snapshot.data );
          } else {
            return Center( child: CircularProgressIndicator() );
          }
        }
      ),
    );
  }

  Widget _createFooterPageView( BuildContext context, List<Actor> actores ) {
    final screenSize = MediaQuery.of( context ).size;

    return SizedBox(
      height: screenSize.height * 0.25,
      child: PageView.builder(
        itemCount: actores.length,
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.333
        ),
        itemBuilder: ( BuildContext context, int index ) {
          return _buildActorCard( actores[ index ], screenSize.height * 0.2 );
        }
      ),
    );
  }

  Widget _buildActorCard( Actor actor, double cardHeight ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular( 15.0 ),
            child: FadeInImage(
              placeholder: AssetImage( 'assets/img/no-image.jpg' ),
              image: NetworkImage( actor.getProfilePath() ),
              fit: BoxFit.cover,
              height: cardHeight
            ),
          ),
          Text(
            actor.name,
            style: TextStyle( fontSize: 10.0 ),
            textAlign: TextAlign.center
          )
        ]
      )
    );
  }
}