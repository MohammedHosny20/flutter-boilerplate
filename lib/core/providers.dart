import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/datasource/app_datasource.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/repository/app_repository.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/auth0_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/data_sources/test_auth_data_source.dart';
import 'package:flutter_boilerplate/app/app_launch/auth/data/repo/auth_repository.dart';
import 'package:flutter_boilerplate/app/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:flutter_boilerplate/app/dashboard/data/repository/dashboard_repository.dart';
import 'package:flutter_boilerplate/app/wishlist/data/datasource/db/local_wishlist_data_source.dart';
import 'package:flutter_boilerplate/app/wishlist/data/repository/wishlist_repository.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/database/app_database.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/preferences/secure_storage_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

// ---------------------------------------------------------------------------
// Infrastructure providers
// ---------------------------------------------------------------------------

/// Provides the [SecureStorageManager] singleton.
final secureStorageManagerProvider = FutureProvider<SecureStorageManager>((
  ref,
) async {
  await SecureStorageManager.init();
  return SecureStorageManager.instance;
});

/// Provides the [MyPreferenceManger] singleton.
final preferenceManagerProvider = FutureProvider<MyPreferenceManger>((ref) {
  return MyPreferenceManger.instance;
});

/// Provides the [EnvManger] singleton.
final envManagerProvider = FutureProvider<EnvManger>((ref) {
  return EnvManger.instance;
});

/// Provides the initialised [AppDatabase] and keeps it alive.
final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final db = await AppDatabase.create();
  ref.onDispose(db.close);
  return db;
});

/// Provides the [LocalWishlistDataSource] built from the [AppDatabase].
final localWishlistDataSourceProvider = FutureProvider<LocalWishlistDataSource>((
  ref,
) async {
  final db = await ref.watch(appDatabaseProvider.future);
  return LocalWishlistDataSource(wishlistDao: db.wishlistDao);
});

/// Provides the configured [Dio] instance.
final dioProvider = FutureProvider<Dio>((ref) {
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
  ref.onDispose(dio.close);
  return dio;
});

/// Provides the [PlayxNetworkClient] built from [Dio].
final networkClientProvider = FutureProvider<PlayxNetworkClient>((ref) async {
  final dio = await ref.watch(dioProvider.future);
  return PlayxNetworkClient(
    dio: dio,
    customHeaders: () async {
      final pref = await ref.read(preferenceManagerProvider.future);
      final token = await pref.token;
      if (token == null) return {};
      return {'authorization': 'Bearer $token'};
    },
    settings: const PlayxNetworkClientSettings(
      exceptionMessages: CustomExceptionMessage(),
    ),
  );
});

/// Provides a [PlayxNetworkClient] pointing at the REST Countries v5 API.
/// v5 requires an API key sent as a bearer token.
final restCountriesClientProvider = FutureProvider<PlayxNetworkClient>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.restCountriesBaseUrl,
      validateStatus: (_) => true,
      followRedirects: true,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      headers: {
        'Authorization': 'Bearer ${Constants.restCountriesApiKey}',
      },
    ),
  );
  dio.addSentry();
  ref.onDispose(dio.close);
  return PlayxNetworkClient(
    dio: dio,
    settings: const PlayxNetworkClientSettings(
      exceptionMessages: CustomExceptionMessage(),
    ),
  );
});

/// Provides the [Auth0] instance.
final auth0Provider = Provider<Auth0>((ref) {
  return Auth0(Constants.auth0Domain, Constants.auth0ClientId);
});

/// Provides the [Auth0Web] instance.
final auth0WebProvider = Provider<Auth0Web>((ref) {
  return Auth0Web(Constants.auth0Domain, Constants.auth0WebClientId);
});

// ---------------------------------------------------------------------------
// Repository providers
// ---------------------------------------------------------------------------

/// Provides the [AuthRepository].
final authRepositoryProvider = FutureProvider<AuthRepository>((ref) async {
  final client = await ref.watch(networkClientProvider.future);
  final pref = await ref.watch(preferenceManagerProvider.future);
  final auth0 = ref.watch(auth0Provider);
  final auth0Web = ref.watch(auth0WebProvider);

  final remoteAuthDataSource = TestAuthDataSource(client: client);
  final auth0DataSource = Auth0AuthDataSource(
    client: client,
    auth0: auth0,
    auth0Web: auth0Web,
  );

  return AuthRepository(
    remoteAuthDataSource: remoteAuthDataSource,
    auth0DataSource: auth0DataSource,
    preferenceManger: pref,
  );
});

/// Provides the [DashboardRepository].
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(dataSource: DashboardDatasource());
});

/// Provides the [WishlistRepository].
final wishlistRepositoryProvider = FutureProvider<WishlistRepository>((ref) async {
  final localDs = await ref.watch(localWishlistDataSourceProvider.future);
  return WishlistRepository(localDatasource: localDs);
});

/// Provides the [AppRepository].
final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepository(dataSource: AppDatasource());
});
