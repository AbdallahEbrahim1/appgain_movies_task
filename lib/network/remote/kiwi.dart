import 'package:appgain_movies_task/features/movie_details/bloc/bloc.dart';
import 'package:appgain_movies_task/features/popular_movies/bloc/bloc.dart';
import 'package:appgain_movies_task/network/remote/server_gate.dart';
import 'package:kiwi/kiwi.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();
  container.registerSingleton((container) => ServerGate.i);

  container.registerFactory(
      (container) => PopularBloc(container.resolve<ServerGate>()));
  container.registerFactory(
      (container) => MoviesDetailsBloc(container.resolve<ServerGate>()));
}
