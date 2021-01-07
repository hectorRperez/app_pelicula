import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Mis dependencias
import 'package:movie_app/src/models/pelicula_model.dart';

class PeliculaProvider{
  final _apikey   = 'e29e7328748cc393a94df8bee7c8ff92';
  final _languaje = 'es-Es';

  bool _cargandoDatos = false;

  int _popularesPage = 0;

  List<Pelicula> _populares = new  List();

  // 1) Crear un controlador
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //3) Crear un metodo para agregar data al StreamController 
  Function (List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  // 4) Crear un metodo para agregar datos a un Stream
  Stream <List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //2) Crar un metodo para cerrar los StreamController
  void disposeStream(){
    _popularesStreamController?.close();
  }


  Future <List<Pelicula>> procesarRespuesta(url) async{
    
    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final pelicula = new Peliculas.fromJsonList(decodeData['results']);
    
    return pelicula.listaItems;
  }

  Future <List<Pelicula>> getPeliculaEnCines() async{
    final _url = Uri.https('api.themoviedb.org', '/3/movie/now_playing',{
        'api_key' : _apikey,   
        'language' : _languaje, 
    });
    
    return await procesarRespuesta(_url);

  }

  Future <List<Pelicula>> getPopulares() async{

    if(_cargandoDatos) return [];
    _cargandoDatos = true;

    _popularesPage++;

    final _url = Uri.https('api.themoviedb.org', '/3/movie/popular',{
      'api_key'  : _apikey,   
      'language' : _languaje,
      'page'     : _popularesPage.toString(),
    });
    final resp = await procesarRespuesta(_url);
    _populares.addAll(resp);

    popularesSink(_populares);

    _cargandoDatos = false;
    return resp;

  }

  Future <List<Pelicula>> buscarPeliculas(String query) async{
    final _url = Uri.https('api.themoviedb.org', '3/search/movie',{
        'api_key'  : _apikey,   
        'language' : _languaje, 
        'query'    : query,
    });
    
    return await procesarRespuesta(_url);

  }

}