import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game_play/core/appImages.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Stack(
            fit: StackFit.passthrough,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(
                  AppImages.backLeeSinSvg,
                  color: Color.fromARGB(255, 229, 28, 68),
                  fit: BoxFit.contain,
                  semanticsLabel: 'Lee Sin',
                ),
              ),
              AspectRatio(
                aspectRatio: 375 / 304,
                child: Image.asset(
                  AppImages.leeSinPng,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 50),
            shrinkWrap: true,
            children: [
              Text(
                'Conecte-se e organize suas jogatinas',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 16),
              Text(
                'Crie grupos para jogar seus games favoritos com seus amigos',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        'assets/svgs/discord.svg',
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 56,
                      color: Color.fromARGB(255, 153, 31, 54),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Entrar com Discord',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
