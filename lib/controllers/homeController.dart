import 'dart:convert';

import 'package:game_play/core/secretKeys.dart';
import 'package:game_play/models/eventModel.dart';
import 'package:game_play/models/guildModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final _eventsList = RxList<EventModel>.empty(growable: true);
  List<EventModel> get eventsList => _eventsList;
  int get eventsCount => _eventsList.length;

  Future<void> getEvents(List<GuildModel> guilds) async {
    try {
      final response = await http.get(
        Uri.http(
          SecretKeys.apiUrl,
          'events',
          {
            'guilds': guilds.map((e) => e.id).toList(),
          },
        ),
      );

      List events = jsonDecode(response.body);

      for (final Map<String, dynamic> event in events) {
        final guild =
            guilds.firstWhere((element) => element.id == event['idGuild']);

        _eventsList.add(EventModel.fromMap({
          ...event,
          'guild': guild.toMap(),
        }));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
