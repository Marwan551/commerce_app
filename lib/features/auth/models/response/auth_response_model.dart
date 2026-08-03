class AuthResponseModel {
  final String? statusMsg;
  final String? message;

  AuthResponseModel({this.statusMsg, this.message});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      statusMsg: json['statusMsg'],
      message: json['message'],
    );
  }
}
