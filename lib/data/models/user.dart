import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserName {
  @JsonKey(name: 'title', includeIfNull: false)
  String title;
  @JsonKey(name: 'first', includeIfNull: false)
  String first;
  @JsonKey(name: 'last', includeIfNull: false)
  String last;

  String get getName => "$title $first $last";

  UserName(this.title, this.first, this.last);

  factory UserName.fromJson(Map<String, dynamic> json) => _$UserNameFromJson(json);
  Map<String, dynamic> toJson() => _$UserNameToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'name', includeIfNull: false)
  UserName name;
  @JsonKey(name: 'gender', includeIfNull: false)
  String gender;
  @JsonKey(name: 'email', includeIfNull: false)
  String email;
  @JsonKey(name: 'picture', includeIfNull: false)
  String avatar;
  @JsonKey(name: 'phone', includeIfNull: false)
  String phone;

  User(this.name, this.gender, this.email, this.avatar, this.phone);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: 'user', includeIfNull: false)
  User user;

  UserData(this.user);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class ResultUser {
  @JsonKey(name: 'results', includeIfNull: false)
  List<UserData> users;

  ResultUser(this.users);

  factory ResultUser.fromJson(Map<String, dynamic> json) => _$ResultUserFromJson(json);
  Map<String, dynamic> toJson() => _$ResultUserToJson(this);

  factory ResultUser.fromMockdata(String json) {
    dynamic jsonMap = jsonDecode(json);
    return _$ResultUserFromJson(jsonMap);
  }
}