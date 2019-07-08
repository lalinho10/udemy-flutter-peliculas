import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/actor_model.dart';

class ActorProvider {
  String _apiKey = '96d4174471b508fca5ba64fda73b00e3';
  String _apiUrl = 'api.themoviedb.org';

  Future<List<Actor>> getMovieCast( int movieId ) async {
    final url = Uri.https( _apiUrl, '/3/movie/$movieId/credits', { 'api_key': _apiKey } );
    final httpResponse = await http.get( url );
    final decodedBody = json.decode( httpResponse.body );
    final bodyList = Actores.formJsonList( decodedBody[ 'cast' ] );

    //bodyList.actores.forEach( ( a ) => print( a.name ) );

    return bodyList.actores;
  }
}