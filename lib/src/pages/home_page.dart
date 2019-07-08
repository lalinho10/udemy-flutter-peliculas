import 'package:flutter/material.dart';

import 'package:peliculas/src/delegates/search_delegate.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/pelicula_provider.dart';

import 'package:peliculas/src/widgets/horizontal_view_widget.dart';
import 'package:peliculas/src/widgets/swiper_card_widget.dart';

class HomePage extends StatelessWidget {
  final peliculaProvider = new PeliculaProvider();

  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Películas' ),
        backgroundColor: Colors.blueGrey[ 700 ],
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate()
              );
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all( 15.0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _createSwiper( context ),
            SizedBox( height: 15.0 ),
            _createFooter( context )
          ],
        )
      )
    );
  }

  Widget _createSwiper( BuildContext context ) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cartelera',
            style: TextStyle( color: Colors.blueGrey[ 700 ] )
          ),
          SizedBox( height: 10.0 ),
          FutureBuilder(
            future: peliculaProvider.getNowPlaying(),
            builder: ( BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot ) {
              if( snapshot.hasData ) {
                return SwiperCard( swiperitems: snapshot.data );
              } else {
                return Center( child: CircularProgressIndicator() );
              }
            }
          )
        ]
      )
    );
  }

  Widget _createFooter( BuildContext context ) {
    peliculaProvider.getPopular();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Populares',
              style: TextStyle( color: Colors.blueGrey[ 700 ] )
            )
          ),
          SizedBox( height: 10.0 ),
          StreamBuilder(
            stream: peliculaProvider.popularesStream,
            builder: ( BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot ) {
              if( snapshot.hasData ) {
                return HorizontalView(
                  viewItems: snapshot.data,
                  loadNextPage: peliculaProvider.getPopular
                );
              } else {
                return Center( child: CircularProgressIndicator() );
              }
            }
          )
        ],
      )
    );
  }
}