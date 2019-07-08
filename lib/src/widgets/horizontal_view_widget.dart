import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/widgets.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class HorizontalView extends StatelessWidget {
  final List<Pelicula> viewItems;
  final Function loadNextPage;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.333
  );

  HorizontalView( { @required this.viewItems, @required this.loadNextPage } );

  @override
  Widget build( BuildContext context ) {
    final screenSize = MediaQuery.of( context ).size;

    _pageController.addListener(() {
      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {
        loadNextPage();
      }
    });

    return Container(
      height: screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: viewItems.length,
        itemBuilder: ( BuildContext context, int index ) {
          return _createCard( context, viewItems[ index ], screenSize.height * 0.2 );
        }
        //children: _createCards( screenSize.height * 0.2 )
      ),
    );
  }

  Widget _createCard( BuildContext context, Pelicula movie, double height ) {
    movie.uniqueId = '${movie.id}-hpvcard';

    final card = Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect (
              borderRadius: BorderRadius.circular( 10.0 ),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                image: NetworkImage( movie.getPosterPath() ),
                fit: BoxFit.cover,
                height: height
              ),
            )
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        timeDilation = 35.0;
        Navigator.pushNamed( context, '/detail', arguments: movie );
      }
    );
  }

  /*List<Widget> _createCards( double height ) {

    return viewItems.map( ( item ) {
      return Container(
        margin: EdgeInsets.only( right: 15.0 ),
        child: Column(
          children: <Widget>[
            ClipRRect (
              borderRadius: BorderRadius.circular( 15.0 ),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                image: NetworkImage( item.getPosterPath() ),
                fit: BoxFit.cover,
                height: height
              ),
            )
          ],
        ),
      );
    }).toList();

  }*/
}