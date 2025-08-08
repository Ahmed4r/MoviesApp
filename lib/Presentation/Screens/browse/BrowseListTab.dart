import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/Discover%20ViewModel.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/DiscoverStates.dart';
import 'package:movies_app/Presentation/Screens/browse/gridItem.dart';

class BrowseListTab extends StatelessWidget {
  static const String routename = 'browselisttab';

  List<String?> genreImages = [
    'https://siskiyou.sou.edu/wp-content/uploads/2022/03/intro-1644532027.webp', // Action
    'https://www.airband.co.uk/wp-content/uploads/2022/07/Raiders-of-the-Lost-Ark.jpg', // Adventure
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAzu5nkrt8Jm_297qMMJsT_j7uI1vz47zCrw&s', // Animation
    'https://i.ytimg.com/vi/BbjnVOaPmxQ/maxresdefault.jpg', // Comedy
    'https://s.studiobinder.com/wp-content/uploads/2019/11/73-Best-Crime-Movies-Featured-StudioBinder-min.jpg', // Crime
    "https://pbblogassets.s3.amazonaws.com/uploads/2016/05/Types-of-Documentary-Cover.jpg",
    'https://imgix.ranker.com/list_img_v2/15181/2775181/original/2775181-u1?auto=format&q=50&fit=crop&fm=pjpg&dpr=2&crop=faces&h=185.86387434554973&w=355', // Drama
    'https://content.active.com/Assets/Active.com+Content+Site+Digital+Assets/Kids/Articles/Family+Movies+That+Will+Inspire+Your+Young+Artist/family+movie+night-carousel.jpg', // Family
    'https://static1.moviewebimages.com/wordpress/wp-content/uploads/2023/07/the-20-best-fantasy-movies-of-all-time.jpg', // Fantasy
    'https://content.artofmanliness.com/uploads/2021/05/1917.jpeg', // History
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT47EmZBv44QZxyrW66MZHYVwPjMSkXyNU9UA&s', // Horror
    'https://www.rollingstone.com/wp-content/uploads/2018/06/rs-247999-RS-10_Great_Music_Movies.jpg', // Music
    'https://assets-prd.ignimgs.com/2022/12/19/22-themaltesefalcon-1440x810-1280x720-1671481062937.jpg', // Mystery
    'https://t3.ftcdn.net/jpg/04/80/58/32/360_F_480583241_oWGE7CYoIRCfmSbFyiSednSls6w7oUzY.jpg', // Romance
    'https://static1.colliderimages.com/wordpress/wp-content/uploads/2022/07/Sci-Fi--Fantasy-Films-2.jpg', // Science Fiction
    'https://static3.bigstockphoto.com/8/8/1/large1500/188264848.jpg', // TV Movie
    'https://www.filmeekeeda.com/wp-content/uploads/2020/04/Untitled-design-1.jpg', // Thriller
    'https://www.tasteofcinema.com/wp-content/uploads/2017/07/maxresdefault-1-1.jpg', // War
    'https://static1.moviewebimages.com/wordpress/wp-content/uploads/2023/02/cowboys-in-the-western-movie-butcher-s-crossing-2023.jpg', // Western
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseViewModel()..getBrowseNames(),
      child: BlocBuilder<BrowseViewModel, BrowseStates>(
        builder: (context, state) {
          if (state is BrowseLoadingStates) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BrowseSuccessStates) {
            final genres = state.response.genres ?? [];
            return Scaffold(
              backgroundColor: Colors.black87,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // No need to navigate here, it's handled in GridItem
                      },
                      child: GridItem(
                        genreName: genres[index].name ?? 'Unknown',
                        imageUrl: genreImages[index] ??
                            "https://ih1.redbubble.net/image.4905811472.8675/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg",
                        genreId: genres[index].id!, // Pass genreId here
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is BrowseErrorStates) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
