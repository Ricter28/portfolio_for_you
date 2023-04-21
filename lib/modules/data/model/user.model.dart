import 'package:flutter_template/modules/data/model/refresh_token.model.dart';
import 'package:flutter_template/modules/domain/entity/user.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserModel implements UserEntity {
  UserModel({
    this.avatar,
    this.email,
    this.name,
    this.phone,
  });

  UserModel copyWith({
    String? avatar,
    String? name,
    String? email,
    String? phone,
  }) =>
      UserModel(
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String? email;

  
  @override
  String? avatar;
  
  @override
  String? name;
  
  @override
  String? phone;
}

@JsonSerializable()
class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final UserModel user;
  final TokenModel token;

  AuthResponseModel({
    required this.user,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
