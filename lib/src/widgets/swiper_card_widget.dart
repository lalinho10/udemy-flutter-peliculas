import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCard extends StatelessWidget {
  final List<Pelicula> swiperitems;

  SwiperCard( { @required this.swiperitems } );

  @override
  Widget build( BuildContext context ) {
    final screenSize = MediaQuery.of( context ).size;

    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.55,
        itemHeight: screenSize.height * 0.45,
        itemBuilder: ( BuildContext context, int index ) {
          swiperitems[ index ].uniqueId = '${swiperitems[ index ].id}-swpcard';

          final card = Hero(
            tag: swiperitems[ index ].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                image: NetworkImage( swiperitems[ index ].getPosterPath() ),
                fit: BoxFit.cover
              )
            )
          );

          return GestureDetector(
            child: card,
            onTap: () {
              timeDilation = 35.0;
              Navigator.pushNamed( context, '/detail', arguments: swiperitems[ index ] );
            }
          );
        },
        itemCount: swiperitems.length,
      ),
    );
  }

}