import 'dart:convert';

class UserModel {
  final String _id;
  String get id => _id;

  final String _username;
  String get username => _username;

  final String _avatar;
  String get avatarUrl =>
      'https://cdn.discordapp.com/avatars/$_id/$_avatar.png';

  UserModel(this._id, this._username, this._avatar);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['id'],
      map['username'],
      map['avatar'],
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
