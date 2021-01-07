import 'package:flutter/material.dart';
import 'package:movie_app/src/models/pelicula_model.dart';

class PageViewHorizontal extends StatelessWidget {
  final List<Pelicula> pelicula;
  final Function siguientePagina;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  PageViewHorizontal({
    Key key,
    @required this.pelicula,
    @required this.siguientePagina,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.3,
      child: PageView.builder(
        itemCount: pelicula.length,
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        pageSnapping: false,
        itemBuilder: (context, i) {
          final cardPelicula =Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                Container(
                  child: Hero(
                    tag: pelicula[i].id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        image: NetworkImage(
                          pelicula[i].getPosterPath(),
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Text(
                  pelicula[i].title,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
          return GestureDetector(
            child: cardPelicula,
            onTap: (){
              Navigator.pushNamed(context, 'pelicula_detalle',arguments: pelicula[i]);
            },
          );
        },
      ),
    );
  }
}
