import 'package:json_annotation/json_annotation.dart';

part 'refresh_token.model.g.dart';
@JsonSerializable()
class TokenModel {
  TokenModel({
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  int expiresIn;
  String accessToken;
  String refreshToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}