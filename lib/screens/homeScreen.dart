import 'package:flutter/material.dart';
import 'package:game_play/widgets/appBarWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context,
      ),
    );
  }
}
