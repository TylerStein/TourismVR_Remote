import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class APIProvider extends ChangeNotifier {
  String token;
  bool get isAuthorized => token != null;
  APIProvider([this.token]);

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

  Future<bool> disconnect() async {
    this.token = null;
    notifyListeners();
  }

  Future<bool> authenticate(String token) async {
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
        this.token = token;
      } else {
        this.token = null;
      }

      notifyListeners();
      return isAuthorized;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> playVideoById(int id) async {
    if (!isAuthorized) {
      print('[APIProvider] Client must be authenticated before making requests');
      return false;
    }

    String url = 'http://192.168.2.16:9000/v1/remote/play/$id';
    String data = jsonEncode({ 'file': id });
    try {
      Response response = await Dio().post(
        url,
        data: data,
        options: Options(
          headers: { 'authorization': token },
          contentType: 'application/json',
        ),
      );

      return response.statusCode == HttpStatus.ok;
    } catch (error) {
      print(error);
      return false;
    }
  }
}