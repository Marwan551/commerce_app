class LoginResponseModel {
  final String? message;
  final User? user;
  final String? token;

  LoginResponseModel({
    this.message,
    this.user,
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user?.toJson(),
      'token': token,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
