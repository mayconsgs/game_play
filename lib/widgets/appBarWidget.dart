import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_play/screens/createEventScreen.dart';
import 'package:get/get.dart';

class AppBarWidget extends PreferredSize {
  final Key? key;
  final BuildContext context;
  final String username;
  final String avatar;

  AppBarWidget({
    required this.context,
    required this.username,
    required this.avatar,
    this.key,
  }) : super(
          preferredSize: const Size.fromHeight(96),
          key: key,
          child: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(255, 36, 49, 137),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(avatar),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Olá, ',
                          style: Theme.of(context).textTheme.headline5,
                          children: [
                            TextSpan(
                              text: username,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .merge(const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Hoje é dia de vitória',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  const Spacer(),
                  Ink(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => CreateEventScreen());
                      },
                      splashRadius: 26,
                      color: Colors.white,
                      icon: Icon(
                        Icons.add,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
}
