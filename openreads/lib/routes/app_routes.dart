class AppRoutes {
  static AppRoutes? _instance;

  AppRoutes._();

  factory AppRoutes() => _instance ??= AppRoutes._();

  String books = '/books';
}
