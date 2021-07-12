import 'package:game_play/core/secretKeys.dart';
import 'package:game_play/screens/homeScreen.dart';
import 'package:get/get.dart';
import 'package:oauth2/oauth2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

enum AuthorizingState {
  defaultState,
  buildAuthorizationUrl,
  requestAuthorization,
  authorized,
}

class AuthController extends GetxController {
  final _authorizationEndpoint =
      Uri.https('discord.com', 'api/oauth2/authorize');
  final _tokenEndpoint = Uri.https('discord.com', 'api/oauth2/token');
  final _redirectUri = Uri.parse('https://gameplay-auth.netlify.app');

  late SharedPreferences _prefs;

  final _authorizationState = Rx(AuthorizingState.defaultState);
  AuthorizingState get authorizationState => _authorizationState.value;

  Client? _client;
  bool get hasClient => _client != null;

  Future<void> createClient() async {
    _prefs = await SharedPreferences.getInstance();
    final discordCredential = _prefs.getString('discordCredential');

    if (discordCredential!.isNotEmpty) {
      final credentials = Credentials.fromJson(discordCredential);

      _client = Client(credentials,
          identifier: SecretKeys.discordClientId,
          secret: SecretKeys.discordClientSecret);

      return;
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
        scopes: ['guilds', 'identify']).toString();

    if (await canLaunch(authorizationUrl)) {
      await launch(authorizationUrl);
    }

    await linkStream.listen((url) async {
      if (url!.isNotEmpty && url.startsWith(_redirectUri.toString())) {
        final responseUrl = Uri.parse(url);

        _client = await grant
            .handleAuthorizationResponse(responseUrl.queryParameters);

        _prefs.setString('discordCredential', _client!.credentials.toJson());

        Get.offAll(() => HomeScreen());
      }
    }).asFuture();
  }
}
