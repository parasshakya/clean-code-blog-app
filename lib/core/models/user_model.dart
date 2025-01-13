import 'package:clean_code_app/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(id: json["_id"], name: json["username"], email: json["email"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "username": name, "email": email};
}
