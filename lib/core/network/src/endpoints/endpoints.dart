part of '../../network.dart';

/// Network path / URL constants.
extension Endpoints on Never {
  static const baseUrl = 'https://sourcya-connect.herokuapp.com';

  static const productsBaseUrl = 'https://dummyjson.com';
  static const products = '/products';
  static const productsSearch = '/products/search';
  static String productById(int id) => '/products/$id';

  /// `POST`
  static const loginViaAuth0 = '/auth/auth0/callback';
  static const login = '/auth/local';
  static const register = '/auth/local/register';
  static const upload = '/upload';

  static const profile = '/users/me';
  static const updateUser = '/users/edit-profile';
}
