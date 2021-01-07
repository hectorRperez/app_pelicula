class Cast{
  List <Actores> listaActores = new List();

  Cast();

  Cast.fromJsonList(List<dynamic> lista){
    if (lista == null ) return;

    for (var item in lista) {
      final actor = Actores.fromJson(item);
      listaActores.add(actor);
    }
  }

}

class Actores {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actores({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actores.fromJson(Map <String,dynamic> json){
    adult         = json['adult'];
    gender        = json['gender'];
    id            = json['id'];
    name          = json['name'];
    originalName  = json['original_name'];
    popularity    = json['popularity'];
    profilePath   = json['profile_path'];
    castId        = json['cast_id'];
    character     = json['character'];
    creditId      = json['credit_id'];
    order         = json['order'];
    job           = json['job'];
  }

  getProfilePath(){
    if(profilePath == null){
      return 'https://iupac.org/wp-content/uploads/2018/05/default-avatar.png';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }

  }

}
