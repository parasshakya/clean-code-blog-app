import 'package:clean_code_app/core/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('_id') ||
        !json.containsKey('username') ||
        !json.containsKey('email')) {
      throw Exception('Invalid User JSON: Missing required fields');
    }
    if (json["_id"] is! String ||
        json["username"] is! String ||
        json["email"] is! String) {
      throw Exception("Invalid User JSON: Incorrect data types");
    }
    return UserModel(
        id: json["_id"], name: json["username"], email: json["email"]);
  }

  Map<String, dynamic> toJson() {
    if (id.isEmpty || name.isEmpty || email.isEmpty) {
      throw Exception('Invalid UserModel: Missing required fields');
    }
    return {"_id": id, "username": name, "email": email};
  }

  factory UserModel.empty() => const UserModel(id: '', name: '', email: '');
}
