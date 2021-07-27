import 'package:flutter/material.dart';
import 'package:game_play/controllers/authController.dart';
import 'package:game_play/controllers/homeController.dart';
import 'package:game_play/core/appImages.dart';
import 'package:game_play/widgets/appBarWidget.dart';
import 'package:game_play/widgets/categoryCardWidget.dart';
import 'package:game_play/widgets/eventListWidget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _homeController = HomeController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        username: _authController.user.username,
        avatar: _authController.user.avatarUrl,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                CategoryCardWidget(
                  iconPath: AppImages.espadasSvg,
                  text: 'Ranked',
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Partidas agendadas',
                style: TextStyle(fontSize: 18),
              ),
              Obx(() {
                return Text(
                  'Total ${_homeController.eventsCount}',
                  style: Theme.of(context).textTheme.subtitle1,
                );
              })
            ],
          ),
          FutureBuilder(
            future: _homeController.getEvents(_authController.guildsList),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                  itemCount: _homeController.eventsCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final event = _homeController.eventsList[index];

                    return EventListWidget(
                      event: event,
                      owner: event.idOwner == _authController.user.id,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 116,
                      height: 0,
                      color: const Color(0xFF1D2766),
                    );
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
