import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/browsestates.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/browseviewmodel.dart';
import 'package:movies_app/Presentation/Screens/browse/gridItem.dart';

class BrowseListTab extends StatelessWidget {
  static const String routename = 'browselisttab';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Browseviewmodel()..getBrowseNames(),
      child: BlocBuilder<Browseviewmodel, Browsestates>(
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
                    return GridItem(genreName: genres[index].name ?? 'Unknown');
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
