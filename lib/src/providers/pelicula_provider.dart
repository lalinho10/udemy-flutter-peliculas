import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaProvider {
  String _apiKey = '96d4174471b508fca5ba64fda73b00e3';
  String _apiUrl = 'api.themoviedb.org';
  String _language = 'es-MX';

  int _page = 0;
  bool _loading = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  Function( List<Pelicula> ) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  Future<List<Pelicula>> _processResponse( Uri url ) async {
    final httpResponse = await http.get( url );
    final decodedBody = json.decode( httpResponse.body );
    final bodyList = Peliculas.fromJsonList( decodedBody[ 'results' ] );

    return bodyList.peliculas;
  }

  Future<List<Pelicula>> getNowPlaying() async {
    final url = Uri.https( _apiUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    return await _processResponse( url );
  }

  Future<List<Pelicula>> getPopular() async {
    if ( _loading ) return [];

    _loading = true;
    _page++;

    final url = Uri.https( _apiUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page.toString()
    });

    final resp = await _processResponse( url );
    _populares.addAll( resp );
    popularesSink( _populares );

    _loading = false;

    return resp;
  }

  Future<List<Pelicula>> searchMovies( String query ) async {
    final url = Uri.https( _apiUrl, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    return await _processResponse( url );
  }

  void disposeStreams() {
    _popularesStreamController?.close();
  }
}