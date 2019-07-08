class Peliculas {
  List<Pelicula> peliculas = new List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for ( var item in jsonList ) {
      final pelicula = new Pelicula.fromJsonMap( item );
      peliculas.add( pelicula );
    }
  }
}



class Pelicula {
  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> jsonMap ) {
    voteCount        = jsonMap[ 'vote_count' ];
    id               = jsonMap[ 'id' ];
    video            = jsonMap[ 'video' ];
    voteAverage      = jsonMap[ 'vote_average' ] / 1;
    title            = jsonMap[ 'title' ];
    popularity       = jsonMap[ 'popularity' ] / 1;
    posterPath       = jsonMap[ 'poster_path' ];
    originalLanguage = jsonMap[ 'original_language' ];
    originalTitle    = jsonMap[ 'original_title' ];
    genreIds         = jsonMap[ 'genre_ids' ].cast<int>();
    backdropPath     = jsonMap[ 'backdrop_path' ];
    adult            = jsonMap[ 'adult' ];
    overview         = jsonMap[ 'overview' ];
    releaseDate      = jsonMap[ 'release_date' ];
  }

  String getPosterPath() {
    if ( posterPath != null ) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    } else {
      return 'https://rimage.gnst.jp/livejapan.com/public/img/common/noimage.jpg?20190520152215';
    }
  }

  String getBackdropPath() {
    if ( backdropPath != null ) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    } else {
      return 'https://rimage.gnst.jp/livejapan.com/public/img/common/noimage.jpg?20190520152215';
    }
  }
}