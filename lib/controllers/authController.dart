import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:game_play/core/secretKeys.dart';
import 'package:game_play/models/guildModel.dart';
import 'package:game_play/models/userModel.dart';
import 'package:game_play/screens/homeScreen.dart';
import 'package:get/get.dart';
import 'package:oauth2/oauth2.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  final _authorizationEndpoint =
      Uri.https('discord.com', 'api/oauth2/authorize');
  final _tokenEndpoint = Uri.https('discord.com', 'api/oauth2/token');
  final _redirectUri = Uri.https('gameplay-auth.netlify.app', '');

  final _secureStorage = FlutterSecureStorage();

  Client? client;
  bool get hasClient => client != null;

  late UserModel _user;
  UserModel get user => _user;

  final List<GuildModel> _guildsList = List.empty(growable: true);
  List<GuildModel> get guildsList => _guildsList;
  bool get hasGuilds => _guildsList.length > 0;

  Future<void> getCredentials() async {
    final discordCredential =
        await _secureStorage.read(key: 'discordCredential');

    if (discordCredential!.isNotEmpty) {
      final credentials = Credentials.fromJson(discordCredential);

      client = Client(credentials,
          identifier: SecretKeys.discordClientId,
          secret: SecretKeys.discordClientSecret);

      if (hasClient) {
        await getUserData();
      }
    }
  }

  Future<void> signIn() async {
    final grant = AuthorizationCodeGrant(
      SecretKeys.discordClientId,
      _authorizationEndpoint,
      _tokenEndpoint,
      secret: SecretKeys.discordClientSecret,
    );

    final authorizationUrl = grant.getAuthorizationUrl(_redirectUri,
        scopes: ['guilds', 'identify', 'email']).toString();

    if (await canLaunch(authorizationUrl)) {
      await launch(authorizationUrl);
    }

    linkStream.listen((url) async {
      if (url!.isNotEmpty && url.startsWith(_redirectUri.toString())) {
        final responseUrl = Uri.parse(url);

        client = await grant
            .handleAuthorizationResponse(responseUrl.queryParameters);

        await _secureStorage.write(
          key: 'discordCredential',
          value: client!.credentials.toJson(),
        );

        if (hasClient) {
          await getUserData();
        }

        Get.offAll(() => HomeScreen());
      }
    });
  }

  Future<void> getUserData() async {
    final data = await Future.wait([
      client!.read(Uri.https('discord.com', 'api/users/@me')),
      client!.read(Uri.https('discord.com', 'api/users/@me/guilds'))
    ]);

    _user = UserModel.fromJson(data[0]);

    List.from(json.decode(data[1])).forEach((element) {
      _guildsList.add(GuildModel.fromMap(element));
    });
  }
}
