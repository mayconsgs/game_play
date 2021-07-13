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
  final _redirectUri = Uri.parse('https://gameplay-auth.netlify.app');

  final _secureStorage = FlutterSecureStorage();

  Client? client;
  bool get hasClient => client != null;

  late UserModel _user;
  UserModel get user => _user;

  final List<GuildModel> _guildsList = List.empty(growable: true);
  List<GuildModel> get guildsList => _guildsList;
  bool get hasGuilds => _guildsList.length > 0;

  Future<void> createClient() async {
    final discordCredential =
        await _secureStorage.read(key: 'discordCredential');

    if (discordCredential!.isNotEmpty) {
      final credentials = Credentials.fromJson(discordCredential);

      client = Client(credentials,
          identifier: SecretKeys.discordClientId,
          secret: SecretKeys.discordClientSecret);
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

    await linkStream.listen((url) async {
      if (url!.isNotEmpty && url.startsWith(_redirectUri.toString())) {
        final responseUrl = Uri.parse(url);

        client = await grant
            .handleAuthorizationResponse(responseUrl.queryParameters);

        await _secureStorage.write(
          key: 'discordCredential',
          value: client!.credentials.toJson(),
        );

        Get.offAll(() => HomeScreen());
      }
    }).asFuture();
  }

  Future<void> getUserData() async {
    final userData =
        await client!.read(Uri.https('discord.com', 'api/users/@me'));

    _user = UserModel.fromJson(userData);
  }

  Future<void> getUserGuilds() async {
    final data =
        await client!.read(Uri.https('discord.com', 'api/users/@me/guilds'));

    final List guilds = json.decode(data);

    _guildsList.clear();
    guilds.forEach((element) {
      _guildsList.add(GuildModel.fromMap(element));
    });
  }
}
