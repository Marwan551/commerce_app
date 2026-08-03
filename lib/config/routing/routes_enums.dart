enum AppRoutes {
  home('/'),
  login('/login'),
  register('/register'),
  forgotPassword('/forgot-password'),
  verifyCode('/verify-code'),
  resetPassword('/reset-password'),
  splash('/splash');

  final String path;
  const AppRoutes(this.path);
}
