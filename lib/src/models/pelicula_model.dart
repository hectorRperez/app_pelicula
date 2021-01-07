class Peliculas{
  
  List <Pelicula> listaItems = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> items){
    if(items == null) return;
    
    for (var item in items) {
      final pelicula = new Pelicula.fromJson(item);
      listaItems.add(pelicula);
    }

  }

}

class Pelicula {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJson(Map <String,dynamic> json){
    adult             = json['adult']; 
    backdropPath      = json['backdrop_path']; 
    genreIds          = json['genre_ids'].cast<int>(); 
    id                = json['id']; 
    originalLanguage  = json['original_language']; 
    originalTitle     = json['original_title']; 
    overview          = json['overview']; 
    popularity        = json['popularity'] / 1; 
    posterPath        = json['poster_path']; 
    releaseDate       = json['release_date']; 
    title             = json['title']; 
    video             = json['video']; 
    voteAverage       = json['vote_average'] /1; 
    voteCount         = json['vote_count']; 
  }

  getPosterPath(){
    if(posterPath == null){
      return 'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

  }

  getbackdropPath(){
    if(backdropPath == null) {
      return 'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}
