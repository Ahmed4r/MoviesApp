import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/SearchScreen/cubit/searchCubit.dart';
import 'package:movies_app/Presentation/Screens/SearchScreen/cubit/searchStates.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabViewmodel.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:readmore/readmore.dart';

class SearchTab extends StatelessWidget {
  static const String routename = 'searchtab';
  Hometabviewmodel movieCubit = Hometabviewmodel();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, Searchstates>(
        builder: (context, state) {
          final viewmodel = BlocProvider.of<SearchCubit>(context);

          return Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search bar with improved styling
                  SizedBox(height: 50.h),
                  TextField(
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    controller: searchController,
                    onChanged: (value) {
                      viewmodel.searchMovie(search: value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      labelText: 'Search For Movie',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),

                  // Display results or loading/error indicators
                  SizedBox(height: 20.h),
                  if (state is SearchLoadingState)
                    Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  else if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewmodel.searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = viewmodel.searchResults[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MovieDetailsPage.routeName,
                                  arguments: {
                                    'movieID': movie.id.toString(),
                                    'movieslist': movieCubit.movies
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80.w,
                                    height: 120.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        '${Const.imagepath}${movie.posterPath}',
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                                    child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        )),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10.0),

                                  // Movie details with improved formatting
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                                .sp, // Use ScreenUtil for responsive text size
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          movie.releaseDate ?? '',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14
                                                .sp, // Use ScreenUtil for responsive text size
                                          ),
                                        ),
                                        ReadMoreText(
                                          movie.overview ?? '',
                                          trimMode: TrimMode.Line,
                                          colorClickableText: Colors.pink,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: 'Show less',
                                          trimLines: 2,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14
                                                .sp, // Use ScreenUtil for responsive text size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else if (state is SearchErrorState)
                    Center(
                      child: Text(
                        'Error occurred while searching for movies , Movie Not found',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
