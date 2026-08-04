class Endpoints {
  Endpoints._();
  static final Endpoints _instance = Endpoints._();
  factory Endpoints() => _instance;

  final String baseUrl = 'https://ecommerce.routemisr.com/api/v1';
  final String login = '/auth/signin';
  final String register = '/auth/signup';
  final String forgotPassword = '/auth/forgotPasswords';
  final String verifyResetCode = '/auth/verifyResetCode';
  final String resetPassword = '/auth/resetPassword';
}
