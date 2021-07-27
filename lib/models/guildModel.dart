import 'dart:convert';

class GuildModel {
  String? _id;
  String? get id => _id;

  String? _name;
  String? get name => _name;

  String? _icon;
  String? get iconUrl => 'https://cdn.discordapp.com/icons/$_id/$_icon.png';

  bool? _owner;
  bool? get owner => _owner;

  GuildModel({
    String? id,
    String? name,
    String? icon,
    bool? owner,
  }) {
    this._id = id;
    this._name = name;
    this._icon = icon;
    this._owner = owner;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'icon': _icon,
      'owner': _owner,
    };
  }

  factory GuildModel.fromMap(Map<String, dynamic> map) {
    return GuildModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      owner: map['owner'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GuildModel.fromJson(String source) =>
      GuildModel.fromMap(json.decode(source));
}
