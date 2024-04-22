class RouteParametersApp {
  static Map<String, String> getMovieInfoParameters({required int id}) {
    return <String, String>{'id': id.toString()};
  }
}
