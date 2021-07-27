import 'dart:convert';

class ParticipantModel {
  late final String _idUser;
  String get idUser => _idUser;

  ParticipantModel({
    required String idUser,
  }) {
    this._idUser = idUser;
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': _idUser,
    };
  }

  factory ParticipantModel.fromMap(Map<String, dynamic> map) {
    return ParticipantModel(
      idUser: map['_idUser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParticipantModel.fromJson(String source) =>
      ParticipantModel.fromMap(json.decode(source));
}
