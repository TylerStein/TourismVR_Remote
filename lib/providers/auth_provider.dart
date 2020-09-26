import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthAPIProvider extends ChangeNotifier {
  String _token;
  String get token => '$_token';
  bool get isAuthorized => token != null;

  AuthAPIProvider({
    String initialToken,
  }) {
    _token = initialToken;
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }

  Future<bool> healthCheck() async {
    String url = 'http://192.168.2.16:9000';
    try {
      Response response = await Dio().get(url);
      return response.statusCode == HttpStatus.ok;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> authenticate(String authCode) async {
    String url = 'http://192.168.2.16:9000/v1/auth/controller';
    String data = jsonEncode({ 'token': token });

    try {
      Response response = await Dio().post(
        url,
        data: data,
        options: Options(
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        this._token = token;
      } else {
        this._token = null;
      }

      notifyListeners();
      return isAuthorized;
    } catch (error) {
      print(error);
      return false;
    }
  }
}