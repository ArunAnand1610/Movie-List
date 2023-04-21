import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list_project/bloc/movieevent.dart';
import 'package:movie_list_project/bloc/movieliststate.dart';
import 'package:movie_list_project/services/apirepostory.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;
  final String defaultQuery = "fun";
  MovieBloc(this._movieRepository) : super(MovieLoadingState()) {
    on<LoadMovieEvent>(
      (event, emit) async {
        emit(MovieLoadingState());
        try {
          final movies =
              await _movieRepository.getMovies(event.query ?? defaultQuery);
          emit(MovieLoadedState(movies));
        } catch (e) {
          emit(MovieErrorState(e.toString()));
        }
      },
    );
  }
}
