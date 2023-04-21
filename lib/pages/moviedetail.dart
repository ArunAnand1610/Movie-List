import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_project/database/moviedatabe.dart';
import 'package:movie_list_project/model/moviemodel.dart';
import 'package:nb_utils/nb_utils.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({super.key, required this.movie});
  final MovieDetails movie;
  final DatabaseService _databaseService = DatabaseService();
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  ClipPath(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Platform.isAndroid
                            ? const Center(child: CircularProgressIndicator())
                            : const Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/1672479762EUKROMA PLUS NEWPiglow Cream.jpg',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if(check==false){
                             check = true;
                          await _databaseService
                              .insertBreed(MovieDetails(
                                  adult: movie.adult,
                                  backdropPath: movie.backdropPath,
                                  id: movie.id,
                                  originalLanguage: movie.originalLanguage,
                                  originalTitle: movie.originalTitle,
                                  overview: movie.overview,
                                  posterPath: movie.posterPath,
                                  releaseDate: movie.releaseDate,
                                  title: movie.title,
                                  voteCount: movie.voteCount,
                                  
                                  ))
                              .then((value) {
                            toast("Sucessfully add to favurites");
                          });
                          }else if(check==true){
                            await _databaseService.deleteBreed(movie.id!);
                             toast("Sucessfully Remove to favurites");
                             check=false;
                          }
                          
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 8, top: 8),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: check == true
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 16),
                child: Text(
                  "${movie.title}",
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.rubik(
                      fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Overview'.toUpperCase(),
                        style: GoogleFonts.rubik(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xff000000)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${movie.overview}",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                            fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Release date'.toUpperCase(),
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff000000)),
                                ),
                                Text(
                                  "${movie.releaseDate}",
                                  style: GoogleFonts.rubik(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff143F6C)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Language'.toUpperCase(),
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff000000)),
                                ),
                                Text(
                                  "${movie.originalLanguage}",
                                  style: GoogleFonts.rubik(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff143F6C)),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Vote Count'.toUpperCase(),
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff000000)),
                                ),
                                Text(
                                  "${movie.voteCount}",
                                  style: GoogleFonts.rubik(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff143F6C)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
