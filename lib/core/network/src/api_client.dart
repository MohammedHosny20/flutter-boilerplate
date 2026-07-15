part of '../network.dart';

abstract class ApiClient {
  const ApiClient._();
  static Future<String?> get apiToken => MyPreferenceManger.instance.token;

  static PlayxNetworkClient? _client;
  static PlayxNetworkClient get client {
    final c = _client;
    if (c == null) {
      throw StateError('ApiClient not initialised. Call init() first.');
    }
    return c;
  }

  static Auth0? _auth0;
  static Auth0 get auth0 {
    final a = _auth0;
    if (a == null) {
      throw StateError('ApiClient not initialised. Call init() first.');
    }
    return a;
  }

  static Auth0Web? _auth0Web;
  static Auth0Web get auth0Web {
    final a = _auth0Web;
    if (a == null) {
      throw StateError('ApiClient not initialised. Call init() first.');
    }
    return a;
  }

  static Future<PlayxNetworkClient> createApiClient() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        validateStatus: (_) => true,
        followRedirects: true,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
      ),
    );

    dio.addSentry();

    return PlayxNetworkClient(
      dio: dio,
      customHeaders: () async {
        final token = await apiToken;
        if (token == null) {
          return {};
        }

        return {
          'authorization': 'Bearer $token',
        };
      },
      settings: const PlayxNetworkClientSettings(
        exceptionMessages: CustomExceptionMessage(),
      ),
      // onUnauthorizedRequestReceived: (res) => _signOut(),
    );
  }

  static Future<void> init() async {
    _client = await ApiClient.createApiClient();

    _auth0 = Auth0(
      Constants.auth0Domain,
      Constants.auth0ClientId,
    );

    _auth0Web = Auth0Web(
      Constants.auth0Domain,
      Constants.auth0WebClientId,
    );
  }
}
