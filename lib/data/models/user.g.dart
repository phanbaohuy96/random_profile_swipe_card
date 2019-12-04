// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserName _$UserNameFromJson(Map<String, dynamic> json) {
  return UserName(
    json['title'] as String,
    json['first'] as String,
    json['last'] as String,
  );
}

Map<String, dynamic> _$UserNameToJson(UserName instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('first', instance.first);
  writeNotNull('last', instance.last);
  return val;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] == null
        ? null
        : UserName.fromJson(json['name'] as Map<String, dynamic>),
    json['gender'] as String,
    json['email'] as String,
    json['picture'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('gender', instance.gender);
  writeNotNull('email', instance.email);
  writeNotNull('picture', instance.avatar);
  writeNotNull('phone', instance.phone);
  return val;
}

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserDataToJson(UserData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user', instance.user);
  return val;
}

ResultUser _$ResultUserFromJson(Map<String, dynamic> json) {
  return ResultUser(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : UserData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultUserToJson(ResultUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('results', instance.users);
  return val;
}
