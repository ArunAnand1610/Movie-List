import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class LoadMovieEvent extends MovieEvent {
  final String? query;

  const LoadMovieEvent([this.query]);

  @override
  List<Object?> get props => [query];
}


