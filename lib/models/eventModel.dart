import 'dart:convert';

import 'package:game_play/models/guildModel.dart';
import 'package:game_play/models/participantModel.dart';
import 'package:game_play/widgets/radioButtonWidget.dart';

class EventModel {
  late String eventId;

  late String idOwner;
  late DateTime schedule;
  late Category category;
  late String description;

  late GuildModel guild;
  late List<ParticipantModel> participants;

  EventModel({
    required this.eventId,
    required this.idOwner,
    required this.schedule,
    required this.category,
    required this.description,
    required this.guild,
    // required this.participants,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'idOwner': idOwner,
      'schedule': schedule.toString(),
      'category': category.toString,
      'description': description,
      'guild': guild.toMap(),
      // 'participants': participants.map((e) => e.toMap()).toList(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'],
      idOwner: map['idOwner'],
      schedule: DateTime.parse(map['schedule']),
      category: map['category'].toString().toCategory,
      description: map['description'],
      guild: GuildModel.fromMap(map['guild']),
      // participants: List<Map<String, dynamic>>.from(map['participants'])
      //     .map((e) => ParticipantModel.fromMap(e))
      //     .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));
}
