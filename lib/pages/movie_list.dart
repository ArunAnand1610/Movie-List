import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movie_list_project/bloc/moviebloc.dart';
import 'package:movie_list_project/bloc/movieliststate.dart';
import 'package:movie_list_project/model/moviemodel.dart';
import 'package:movie_list_project/pages/moviedetail.dart';




class MovileListPage extends StatelessWidget {
  const MovileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MovieErrorState) {
          return const Center(child: Text("Error"));
        }
        if (state is MovieLoadedState) {
          List<MovieDetails> userList = state.movies;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (_, index) {
              final movielist = userList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movielist,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/${movielist.posterPath}",
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/1672479762EUKROMA PLUS NEWPiglow Cream.jpg",
                            );
                          },
                        ),
                      ),
                      title: Text(
                        "${movielist.originalTitle}",
                        style: GoogleFonts.rubik(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Container();
      }),
    );
  }
}
