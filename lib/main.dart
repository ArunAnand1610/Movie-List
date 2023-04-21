import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_list_project/bloc/moviebloc.dart';

import 'package:movie_list_project/pages/searchmovielist.dart';
import 'package:movie_list_project/services/apirepostory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (BuildContext context) => MovieBloc(MovieRepository()),
          ),
        ],
        child: const SearchMovieList(),
      ),
    );
  }
}
