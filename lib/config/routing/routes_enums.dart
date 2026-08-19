enum AppRoutes {
  home('/'),
  login('/login'),
  register('/register'),
  forgotPassword('/forgot-password'),
  verifyCode('/verify-code'),
  resetPassword('/reset-password'),
  productDetails('/product-details'),
  reviews('/reviews'),
  cart('/cart'),
  splash('/splash');

  final String path;
  const AppRoutes(this.path);
}
