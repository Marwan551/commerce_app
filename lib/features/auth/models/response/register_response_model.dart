class RegisterResponseModel {
  final String? message;
  final User? user;
  final String? token;

  RegisterResponseModel({
    this.message,
    this.user,
    this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

class User {
  final String? name;
  final String? email;
  final String? role;

  User({this.name, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
