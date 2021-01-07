import 'package:flutter/material.dart';

// Mis dependencias
import 'package:movie_app/src/models/actores_models.dart';
import 'package:movie_app/src/models/pelicula_model.dart';
import 'package:movie_app/src/providers/actores_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  final actor = ActorProvider();

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _posterTitulo(context, pelicula),
                _descripionMovie(pelicula),
                _actoresPeliculas(pelicula),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      forceElevated: true,
      elevation: 10.0,
      pinned: true,
      centerTitle: true,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(
            pelicula.getbackdropPath(),
          ),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),
        ),
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
          child: Container(
            child: Hero(
              tag: pelicula.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPosterPath()),
                  height: 150.0,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                pelicula.releaseDate,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Row(
                children: [
                  Icon(Icons.star_border_outlined),
                  Text(
                    pelicula.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _descripionMovie(Pelicula pelicula) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _actoresPeliculas(Pelicula pelicula) {
    return FutureBuilder(
      future: actor.getActores(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _mostrarActoresHorizontal(snapshot.data, context);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _mostrarActoresHorizontal(List<Actores> actor, BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.3,
      child: PageView(
          physics: BouncingScrollPhysics(),
          controller: PageController(
            initialPage: 1,
            viewportFraction: 0.3,
          ),
          pageSnapping: false,
          children: actor.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(e.getProfilePath()),
                      fit: BoxFit.cover,
                      height: 150.0,
                    ),
                  ),
                  Text(
                    e.name,
                    style: TextStyle(

                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}
