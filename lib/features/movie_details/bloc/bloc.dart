import 'package:appgain_movies_task/network/remote/server_gate.dart';
import 'package:bloc/bloc.dart';

import 'model.dart';

part 'event.dart';
part 'state.dart';

class MoviesDetailsBloc extends Bloc<MoviesDetailsEvents, MoviesDetailsStates> {
  final ServerGate dio;

  MoviesDetailsBloc(this.dio) : super(MoviesDetailsStates()) {
    on<GetMoviesDetailsEvent>(_getMoviesDetails);
  }

  Future _getMoviesDetails(
      GetMoviesDetailsEvent event, Emitter<MoviesDetailsStates> emit) async {
    emit(GetMoviesDetailsLoadingState());
    final response = await dio.getFromServer(
      // url: ApiNames.getMoviesDetails(id: event.id),
      url: 'https://api.themoviedb.org/3/movie/${event.id}?language=en-US',
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOWUzZTBiYTkwY2JkYTI1OThjNzM3ZGEzNWE0NTg2YSIsInN1YiI6IjY0ZDI0YzJiOTQ1ZDM2MDBmZmNmMjhkMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FgUJYTiCINk42qGkNatToAzWu_VTwP50q3KIDJMLOSo',
      },
    );
    if (response.success) {
      final model = MoviesDetailsModel.fromJson(
        response.response!.data,
      );
      emit(
        GetMoviesDetailsSuccessState(
          msg: response.msg,
          data: model,
        ),
      );
    } else {
      emit(GetMoviesDetailsFailedState(msg: response.msg));
    }
  }
}

//String token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOWUzZTBiYTkwY2JkYTI1OThjNzM3ZGEzNWE0NTg2YSIsInN1YiI6IjY0ZDI0YzJiOTQ1ZDM2MDBmZmNmMjhkMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FgUJYTiCINk42qGkNatToAzWu_VTwP50q3KIDJMLOSo";
