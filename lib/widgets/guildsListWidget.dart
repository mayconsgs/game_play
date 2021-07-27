import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_play/controllers/authController.dart';
import 'package:game_play/controllers/createEventController.dart';
import 'package:get/get.dart';

class GuildsListWidget extends StatelessWidget {
  final AuthController _authController = Get.find();
  final CreateEventController createEventController;

  GuildsListWidget({
    Key? key,
    required this.createEventController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 24),
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final guild = _authController.guildsList[index];

        return InkWell(
          onTap: () {
            createEventController.selectGuild(guild);
            Get.back();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: guild.iconUrl!,
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guild.name!,
                      style: const TextStyle(fontSize: 18),
                      softWrap: true,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      guild.owner! ? 'Administrador' : 'Convidado',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Icon(
                  Icons.chevron_right,
                  color: Color(0xFFABB1CC),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          indent: 116,
          height: 0,
          color: const Color(0xFF1D2766),
        );
      },
      itemCount: _authController.guildsList.length,
    );
  }
}
