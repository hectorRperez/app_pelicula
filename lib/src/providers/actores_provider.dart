

import 'dart:convert';

// Mis dependencias
import 'package:movie_app/src/models/actores_models.dart';
import 'package:http/http.dart' as http;

class ActorProvider{
  final _apikey   = 'e29e7328748cc393a94df8bee7c8ff92';
  final _languaje = 'es-Es';

  Future <List<Actores>> procesarRespuesta(url) async{

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    
    final actor = new Cast.fromJsonList(decodeData['cast']);
    
    return actor.listaActores;
  }

  Future <List<Actores>> getActores(int idActor) async{
    final url = Uri.https('api.themoviedb.org','3/movie/$idActor/credits',{
      'api_key' : _apikey,   
      'language' : _languaje,
    });
    return await procesarRespuesta(url);
  }

}