enum AppRoutes {
  home('/'),
  login('/login'),
  register('/register'),
  forgetPassword('/forget-password'),
  splash('/splash');

  final String path;
  const AppRoutes(this.path);
}
