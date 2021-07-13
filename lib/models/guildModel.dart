import 'dart:convert';

class GuildModel {
  final String _id;

  final String _name;
  String get name => _name;

  final String _icon;
  String get iconUrl => 'https://cdn.discordapp.com/icons/$_id/$_icon.png';

  GuildModel(this._id, this._name, this._icon);

  factory GuildModel.fromMap(Map<String, dynamic> map) {
    return GuildModel(
      map['id'],
      map['name'],
      map['icon'],
    );
  }

  factory GuildModel.fromJson(String source) =>
      GuildModel.fromMap(json.decode(source));
}
