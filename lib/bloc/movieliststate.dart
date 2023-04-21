
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_list_project/model/moviemodel.dart';

@immutable
abstract class MovieState extends Equatable {}

class MovieLoadingState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoadedState extends MovieState {
  final List<MovieDetails> movies;
  MovieLoadedState(this.movies);
  @override
  List<Object?> get props => [movies];
}

class MovieErrorState extends MovieState {
  final String error;
  MovieErrorState(this.error);
  @override
  List<Object?> get props => [error];
}