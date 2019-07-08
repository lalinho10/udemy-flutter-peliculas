import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/movie_detail_page.dart';

void main() => runApp( PeliculasApp() );

class PeliculasApp extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/'       : ( BuildContext context ) => HomePage(),
        '/detail' : ( BuildContext context ) => MovieDetailPage()
      }
    );
  }
}