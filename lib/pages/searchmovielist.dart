import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_project/bloc/moviebloc.dart';
import 'package:movie_list_project/bloc/movieevent.dart';



import 'package:movie_list_project/pages/movie_list.dart';

class SearchMovieList extends StatefulWidget {
  const SearchMovieList({super.key});

  @override
  State<SearchMovieList> createState() => _SearchMovieListState();
}

class _SearchMovieListState extends State<SearchMovieList> {
  late MovieBloc _movieBloc;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _movieBloc = context.read<MovieBloc>();
    _movieBloc.add(const LoadMovieEvent());
  }

  void _search(String query) {
    if (query.isEmpty) {
      return;
    }
    _movieBloc.add(LoadMovieEvent(query));
    print("loading movies");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2A29E8),
          title: Center(
            child: Text(
              "Movie List",
              style: GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _search(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search Movie",
                      hintStyle: GoogleFonts.rubik(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          _searchController.clear();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: MovileListPage())
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 30,
        width: 30,
        child:
            movie.poster != null ? Image.network(movie.poster!) : Container(),
      ),
      title: Text(movie.name),
    );
  }
}

@immutable
class Movie {
  final String name;
  final String? poster;

  const Movie(this.name, this.poster);

  factory Movie.fromMap(Map<String, dynamic> data) {
    return Movie(
      data["original_title"],
      data["poster_path"],
    );
  }
}
