import 'package:flutter/material.dart';

// Mis dependencias
import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/pelicula_detalle.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion de Peliculas',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/'                : (BuildContext context) => HomePage(),
        'pelicula_detalle' : (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}