import 'package:flutter/material.dart';
import 'package:game_play/core/appImages.dart';
import 'package:game_play/widgets/appBarWidget.dart';
import 'package:game_play/widgets/categoryCardWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
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
              Text(
                'Total ${8}',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          )
        ],
      ),
    );
  }
}
