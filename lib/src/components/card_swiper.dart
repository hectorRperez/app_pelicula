import 'package:flutter/material.dart';

// Mis dependencias
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child:  GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'pelicula_detalle',arguments: peliculas[index]);
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peliculas[index].getPosterPath()),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          itemCount: 10,
          itemWidth: _size.width * 0.7,
          itemHeight: _size.height * 0.5,
          layout: SwiperLayout.STACK,
        ),
      ),
    );
  }
}
