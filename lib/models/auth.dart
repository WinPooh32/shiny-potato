import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AuthModel with ChangeNotifier {
  final DefaultApi _api;
  String email;
  String password;

  bool _loading = false;
  bool _success = false;

  AuthModel(this._api);

  bool get success => _success;
  bool get loading => _loading;

  Future<void> login() async {
    var authBody = AuthBody();
    authBody.email = email;
    authBody.password = password;
    
    _loading = true;
    notifyListeners();

    APIKey token = await _api.authByPassword(authBody);
    _setTokenToClient(token);

    _loading = false;
    notifyListeners();
  }

  _setTokenToClient(APIKey token) {
    if (token == null) {
      return;
    }
    var auth = _api.apiClient.getAuthentication<ApiKeyAuth>("myKey");
    auth.apiKey = token.key;
    _success = true;
  }
}
