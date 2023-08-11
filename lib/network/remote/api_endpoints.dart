class ApiNames {
  static const String getPopular = "";
  static String getMovieRate({required int id}) {
    return "Movie/$id/rates";
  }
}
