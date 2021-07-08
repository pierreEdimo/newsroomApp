class UserModel {
  final String? id;
  final String? userName;
  final String? email;

  UserModel({this.email, this.id, this.userName});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        userName: json['userName'] as String,
        email: json['email'] as String,
      );
}
