import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_play/controllers/authController.dart';
import 'package:get/get.dart';

class CreateEventScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  CreateEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _authController.getUserGuilds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Scaffold(
              appBar: AppBar(
                title: Text('Agendar partida'),
                centerTitle: true,
              ),
              body: ListView.separated(
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          height: 68,
                          width: 68,
                          margin: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  _authController.guildsList[index].iconUrl),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 48,
                      color: Color(0xFF1D2766),
                    );
                  },
                  itemCount: _authController.guildsList.length),
            );

          return Center(child: CircularProgressIndicator());
        });
  }
}
