import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_play/models/eventModel.dart';
import 'package:game_play/widgets/radioButtonWidget.dart';

class EventListWidget extends StatelessWidget {
  final EventModel event;
  final bool owner;

  const EventListWidget({required this.event, required this.owner, Key? key})
      : super(key: key);

  String get eventCategory {
    switch (event.category) {
      case Category.duel:
        return 'Duelo';
      case Category.joke:
        return 'Diversão';
      case Category.ranked:
        return 'Ranqueada';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          child: CachedNetworkImage(
            imageUrl: event.guild.iconUrl ?? '',
            width: 68,
            height: 68,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(width: 24),
        SizedBox(
          height: 52,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.guild.name ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    eventCategory,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${event.schedule.day}/${event.schedule.month} às ${event.schedule.hour}:${event.schedule.minute}h',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),

                  // TODO: Precisa virar um spacer depois
                  const SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    owner ? 'Anfitrião' : 'Convidado',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
