import 'package:flutter/material.dart';

// Mis dependencias
import 'package:movie_app/src/components/card_swiper.dart';
import 'package:movie_app/src/components/page_view_horizontal.dart';
import 'package:movie_app/src/providers/pelicula_provider.dart';
import 'package:movie_app/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final pelicula = PeliculaProvider();

  @override
  Widget build(BuildContext context) {

    pelicula.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _itemsCardSwiper(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 40.0),
                child: _footer(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget 1
  Widget _itemsCardSwiper() {
    return FutureBuilder(
      future: pelicula.getPeliculaEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Peliculas Populares',
                style:Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ),
        StreamBuilder(
          stream: pelicula.popularesStream,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return PageViewHorizontal(pelicula: snapshot.data,siguientePagina: pelicula.getPopulares,);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
