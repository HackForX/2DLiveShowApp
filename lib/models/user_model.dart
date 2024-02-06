import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String userName;
  String password;
  bool isAdmin;

  UserModel({
    required this.id,
    required this.userName,
    required this.password,
    required this.isAdmin
  });

  factory UserModel.fromJson(Map<String,dynamic> json) {

    return UserModel(
      id: json['id']??"",
      userName: json['user_name'] ?? "",
      password: json['password'] ?? "",
      isAdmin: json['is_admin']??false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      
      'user_name': userName,
      'password': password,
      'is_admin':isAdmin
    };
  }
}
