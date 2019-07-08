class Actores {
  List<Actor> actores = new List();

  Actores();

  Actores.formJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for ( var item in jsonList ) {
      final actor = new Actor.fromJsonMap( item );
      actores.add( actor );
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> jsonMap ) {
    this.castId      = jsonMap[ 'cast_id' ];
    this.character   = jsonMap[ 'character' ];
    this.creditId    = jsonMap[ 'credit_id' ];
    this.gender      = jsonMap[ 'gender' ];
    this.id          = jsonMap[ 'id' ];
    this.name        = jsonMap[ 'name' ];
    this.order       = jsonMap[ 'order' ];
    this.profilePath = jsonMap[ 'profile_path' ];
  }

  String getProfilePath() {
    if ( profilePath != null ) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    } else {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5I_HJjetUSv-wCCDgwssMMXSi7lvOo-Ph5qcBDC-_WRG05vr7';
    }
  }
}