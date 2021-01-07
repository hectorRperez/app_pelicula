import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

// Mis dependencias
import 'package:movie_app/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  PeliculaProvider peliculaProvider = new PeliculaProvider();
  String _seleccion = '';

  final pelicula = [
    'Spiderman',
    'Aquaman',
    'BAtman',
    'Shazan',
    'Ironman',
    'Capitan America'
  ];

  final peliculaRecientes = [
    'Spiderman',
    'Capitan America',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono de la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container(
      height: 100.0,
      width: 100.0,
      color: Colors.indigoAccent,
      child: Text(_seleccion),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: peliculaProvider.buscarPeliculas(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculaSugerida = snapshot.data;
            return ListView(
                children: peliculaSugerida.map((e) {
              return ListTile(
                title: Text(e.title),
                leading: FadeInImage(
                  width: 50.0,
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(e.getPosterPath()),
                  fit: BoxFit.cover,
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'pelicula_detalle',arguments: e);
                },
              );
            }).toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

    // final busquedaSugerida = (query.isEmpty)
    //     ? peliculaRecientes
    //     : pelicula
    //         .where((peli) => peli.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // print(busquedaSugerida);

    // return ListView.builder(
    //   itemCount: busquedaSugerida.length,
    //   itemBuilder: (context, int index) {
    //     return ListTile(
    //       title: Text(busquedaSugerida[index]),
    //       leading: Icon(Icons.movie),
    //       onTap: (){
    //         _seleccion = busquedaSugerida[index];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
  }
}
