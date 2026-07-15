part of '../../network.dart';

/// contains network endpoints.
abstract class Endpoints {
  static const baseUrl = "https://sourcya-connect.herokuapp.com";

  /// REST Countries API v5 — used by the countries feature.
  static const restCountriesBaseUrl = "https://api.restcountries.com/countries/v5";

  /// `POST`
  static const loginViaAuth0 = '/auth/auth0/callback';
  static const login = '/auth/local';
  static const register = '/auth/local/register';
  static const upload = '/upload';

  static const profile = '/users/me';
  static const updateUser = '/users/edit-profile';
}
